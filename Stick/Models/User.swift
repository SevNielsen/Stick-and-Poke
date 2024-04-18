//
//  User.swift
//  Stick
//
//  Created by Sev Nielsen on 2024-04-18.
//

import Foundation
import CoreLocation

struct User {
    var id: String
    var username: String
    var profileImageURL: URL?
    var lastKnownLocation: CLLocation?
}
