//
//  StateDetailViewModel.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI

@Observable
class StateDetailViewModel {
    var chartData: [MonthlyChartData] = []
    var chartErrorMessage: String?
    
    let state: StateData
    private var chartDataService: ChartDataService
    
    init(state: StateData, chartDataService: ChartDataService = ChartDataService()) {
        self.state = state
        self.chartDataService = chartDataService
    }
    
    func fetchMonthlyCrimeCounts(offenseCode: String) {
        Task {
            do {
                let data = try await chartDataService.getMonthlyChartData(
                    offenseCode: offenseCode,
                    stateName: state.name,
                    stateAbbr: state.abbreviation
                )
                await MainActor.run {
                    self.chartData = data
                }
            } catch {
                await MainActor.run {
                    self.chartErrorMessage = "Failed to load chart data: \(error.localizedDescription)"
                    print(self.chartErrorMessage!)
                }
            }
        }
    }
}
