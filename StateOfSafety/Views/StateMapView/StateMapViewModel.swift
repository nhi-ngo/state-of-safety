//
//  StateMapViewModel.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI
import MapKit

@Observable
class StateMapViewModel {
    var states: [StateData] = []
    var cameraPosition: MapCameraPosition
    
    init() {
        let continentalUSCenter = CLLocationCoordinate2D(latitude: 39.8283, longitude: -98.5795)
        let span = MKCoordinateSpan(latitudeDelta: 35, longitudeDelta: 35)
        let region = MKCoordinateRegion(center: continentalUSCenter, span: span)
        self.cameraPosition = .region(region)
        
        loadStateData()
    }
    
    func loadStateData() {
        guard let url = Bundle.main.url(forResource: "statesData", withExtension: "json") else {
            print("❌ Couldn't find json data in main bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.states = try decoder.decode([StateData].self, from: data)
        } catch {
            print("❌ Couldn't parse json data from main bundle: \n\(error)")
        }
    }
}
