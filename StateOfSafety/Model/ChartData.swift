//
//  ChartData.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import SwiftUI

struct MonthlyChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
    let stateName: String
}

struct MonthlyChartAPIResponse: Codable {
    let offenses: OffensesContainer?
    
    struct OffensesContainer: Codable {
        let actuals: [String: [String: Int?]]?
    }
}

struct ArrestDemographicsAPIResponse: Decodable {
    let arresteeSex: [String: Int]?
    let arresteeRace: [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case arresteeSex = "Arrestee Sex"
        case arresteeRace = "Arrestee Race"
    }
}

struct BarChartSegment: Identifiable {
    let id = UUID()
    let category: String
    let value: Double
    var color: Color
}

enum DemographicsType: String, CaseIterable, Identifiable {
    case sex, race
    var id: Self { self }
}
