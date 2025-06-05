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
    
    let mockRaceData: [BarChartSegment] = [
        BarChartSegment(category: "American Indian or Alaska Native", value: 448, color: .teal),
        BarChartSegment(category: "Asian", value: 100, color: .green),
        BarChartSegment(category: "Black or African American", value: 1632, color: .orange),
        BarChartSegment(category: "Native Hawaiian or Other Pacific Islander", value: 50, color: .purple),
        BarChartSegment(category: "Unknown", value: 100, color: .red),
        BarChartSegment(category: "White", value: 1843, color: .cyan),
        BarChartSegment(category: "Not Specified", value: 312, color: .gray)
    ]
    
    let mockSexData: [BarChartSegment] = [
        BarChartSegment(category: "Male", value: 1211, color: .blue),
        BarChartSegment(category: "Female", value: 206, color: .pink)
    ]
}
