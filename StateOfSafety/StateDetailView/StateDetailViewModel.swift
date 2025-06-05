//
//  StateDetailViewModel.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI

@Observable
class StateDetailViewModel {
    let state: StateData
    private var chartDataService: ChartDataService
    var selectedCrime: CrimeType = crimeTypes.first!
    
    var chartData: [MonthlyChartData] = []
    var chartErrorMessage: String?

    var arrestSexData: [BarChartSegment] = []
    var arrestRaceData: [BarChartSegment] = []
    
    init(state: StateData, chartDataService: ChartDataService = ChartDataService()) {
        self.state = state
        self.chartDataService = chartDataService
    }
    
    func fetchDataForSelectedCrime() {
        fetchMonthlyCrimeCounts(offenseCode: selectedCrime.abbr)
        fetchArrestDemographics()
    }
    
    func fetchArrestDemographics() {
        Task {
            do {
                let (sexData, raceData) = try await chartDataService.getArrestDemographicsData(
                    stateAbbr: state.abbreviation,
                    crimeCode: selectedCrime.code
                )
                await MainActor.run {
                    self.arrestSexData = sexData
                    self.arrestRaceData = raceData
                }
            } catch {
                await MainActor.run {
                    self.chartErrorMessage = "Failed to load arrest demographics: \(error.localizedDescription)"
                    print(self.chartErrorMessage!)
                }
            }
        }
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
