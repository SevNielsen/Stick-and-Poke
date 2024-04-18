//
//  MainViewController.swift
//  Stick
//
//  Created by Sev Nielsen on 2024-04-18.
//

import Foundation
import UIKit
import CoreLocation
import UserNotifications

// MARK: - Main View Controller
class MainViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    var locationManager: CLLocationManager!
    var nearbyDevices: [Device] = []
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupTableView()
        requestNotificationPermission()
    }

    // MARK: - Setup Location Manager
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - CLLocationManagerDelegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateNearbyDevicesBasedOn(location: location)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    // MARK: - Simulate Nearby Devices
    private func updateNearbyDevicesBasedOn(location: CLLocation) {
        // Simulate nearby devices
        let simulatedData = [Device(name: "John's iPhone", distance: "10m"), Device(name: "Alice's iPad", distance: "15m")]
        nearbyDevices = simulatedData
        tableView.reloadData()
        notifyUserAboutDevices()
    }

    // MARK: - Notification Setup
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted: \(granted)")
        }
    }

    private func notifyUserAboutDevices() {
        let content = UNMutableNotificationContent()
        content.title = "New Device Detected"
        content.body = "There is a new device nearby. Tap to view."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "DeviceNearby", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }

    // MARK: - TableView DataSource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyDevices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let device = nearbyDevices[indexPath.row]
        cell.textLabel?.text = "\(device.name) - \(device.distance)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open profile view or initiate an interaction
    }
}

// MARK: - Device Model
struct Device {
    var name: String
    var distance: String
}
