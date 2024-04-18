//
//  LocationServiceTests.swift
//  StickTests
//
//  Created by Sev Nielsen on 2024-04-18.
//

import XCTest
import CoreLocation
@testable import Stick

class LocationServiceTests: XCTestCase {

    var locationService: LocationService!

    override func setUp() {
        super.setUp()
        locationService = LocationService.shared
    }

    override func tearDown() {
        locationService = nil
        super.tearDown()
    }

    func testLocationUpdate() {
        let expectation = self.expectation(description: "Location update")
        var locationUpdateReceived = false

        // Simulate location update
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.locationService.locationManager(self.locationService.locationManager, didUpdateLocations: [CLLocation(latitude: 40.7128, longitude: -74.0060)])
            locationUpdateReceived = true
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertTrue(locationUpdateReceived, "Location update was not received.")
    }
}
