//
//  StateData.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI
import CoreLocation

struct StateData: Decodable, Identifiable {
    let id: Int
    let name: String
    let abbreviation: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
    }
}
