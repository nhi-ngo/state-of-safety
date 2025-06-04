//
//  MockData.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import Foundation

struct MockData {
    
    let mockState: StateData = StateData(
        id: 1001,
        name: "Alabama",
        abbreviation: "AL",
        latitude: 32.8067,
        longitude: -86.7911
    )
    
    let monthlyCounts: [MonthlyChartData] = [
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2021, month: 1, day: 1).date!, value: 120.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2021, month: 2, day: 1).date!, value: 115.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2021, month: 3, day: 1).date!, value: 130.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2022, month: 1, day: 1).date!, value: 135.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2022, month: 2, day: 1).date!, value: 150.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2022, month: 3, day: 1).date!, value: 145.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2023, month: 1, day: 1).date!, value: 170.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2023, month: 2, day: 1).date!, value: 150.0, stateName: "Florida"),
        MonthlyChartData(date: DateComponents(calendar: .current, year: 2023, month: 3, day: 1).date!, value: 160.0, stateName: "Florida")
    ]
}
