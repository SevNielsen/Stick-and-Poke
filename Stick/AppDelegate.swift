//
//  AppDelegate.swift
//  Stick
//
//  Created by Sev Nielsen on 2024-04-18.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Start the location service
        let locationService = LocationService.shared
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // wait a few seconds for location to update
            if let location = locationService.currentLocation {
                print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            } else {
                print("No location detected yet.")
            }
        }
        return true
    }

    // other app delegate methods...
}
