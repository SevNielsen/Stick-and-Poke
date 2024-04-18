//
//  Sticks.swift
//  Stick
//
//  Created by Sev Nielsen on 2024-04-18.
//

import Foundation
import CoreLocation

struct Device {
    var id: String
    var proximityUUID: UUID
    var lastDetectedLocation: CLLocation?
    var distance: Double?
}
