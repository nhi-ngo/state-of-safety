//
//  Untitled.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import Foundation

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

