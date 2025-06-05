//
//  ChartDataService.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import SwiftUI

class ChartDataService {
    private let apiKey: String = "7b0dihrbGuBK3D81mD1MdZKvAsEPW0CLwHi5JM86"
    private let baseURL = "https://api.usa.gov/crime/fbi/cde"
    
    func getMonthlyChartData(
        offenseCode: String,
        stateName: String,
        stateAbbr: String,
        fromYear: Int = 2021,
        toYear: Int = 2023
    ) async throws -> [MonthlyChartData] {
        
        let fromDateString = "01-\(fromYear)"
        let toDateString = "12-\(toYear)"
        
        let urlString = "\(baseURL)/summarized/state/\(stateAbbr)/\(offenseCode)?from=\(fromDateString)&to=\(toDateString)&API_KEY=\(apiKey)"
        
        let response: MonthlyChartAPIResponse = try await fetchData(fromUrl: urlString)
        
        var chartData: [MonthlyChartData] = []
        
        guard let stateActualsData = response.offenses?.actuals?[stateName] else {
            return []
        }
        
        for (monthYearKey, actualValue) in stateActualsData {
            if let date = monthYearStringToDate(monthYearKey), let count = actualValue {
                let yearComponent = Calendar.current.component(.year, from: date)
                if yearComponent >= fromYear && yearComponent <= toYear {
                    chartData.append(MonthlyChartData(
                        date: date,
                        value: Double(count),
                        stateName: stateName
                    ))
                }
            }
        }
        
        if chartData.isEmpty && response.offenses?.actuals?[stateName] != nil {
            print("Warning: Data for state '\(stateName)' was present in 'actuals' but no points matched the date range or parsing failed for \(offenseCode).")
        }

        return chartData.sorted { $0.date < $1.date }
    }
    
    func getArrestDemographicsData(
        stateAbbr: String,
        crimeCode: Int,
        fromYear: Int = 2021,
        toYear: Int = 2023
    ) async throws -> (sexData: [BarChartSegment], raceData: [BarChartSegment]) {

        let fromDateString = "01-\(fromYear)"
        let toDateString = "12-\(toYear)"

        let urlString = "\(baseURL)/arrest/state/\(stateAbbr)/\(crimeCode)?type=totals&from=\(fromDateString)&to=\(toDateString)&API_KEY=\(apiKey)"

        let response: ArrestDemographicsAPIResponse = try await fetchData(fromUrl: urlString)

        var sexData: [BarChartSegment] = []
        if let sexBreakdown = response.arresteeSex {
            let sexColors: [String: Color] = [
                "Male": .blue,
                "Female": .pink,
                "Unknown": .gray
            ]
            for (sexCategory, count) in sexBreakdown {
                if count > 0 {
                    sexData.append(BarChartSegment(
                        category: sexCategory,
                        value: Double(count),
                        color: sexColors[sexCategory] ?? .orange
                    ))
                }
            }
        } else {
            print("Warning: No 'Arrestee Sex' data found in arrest demographics response for \(stateAbbr), code \(crimeCode).")
        }

        var raceData: [BarChartSegment] = []
        if let raceBreakdown = response.arresteeRace {
            let raceColors: [String: Color] = [
                "White": .green,
                "Black or African American": .purple,
                "Asian": .yellow,
                "American Indian or Alaska Native": .teal,
                "Native Hawaiian or Other Pacific Islander": .mint,
                "Unknown": .gray,
                "Multiple": .brown,
                "Not Specified": .gray.opacity(0.5)
            ]
            for (raceCategory, count) in raceBreakdown {
                if count > 0 {
                    raceData.append(BarChartSegment(
                        category: raceCategory,
                        value: Double(count),
                        color: raceColors[raceCategory] ?? .indigo
                    ))
                }
            }
        } else {
            print("Warning: No 'Arrestee Race' data found in arrest demographics response for \(stateAbbr), code \(crimeCode).")
        }
        
        sexData.sort { $0.category < $1.category }
        raceData.sort { $0.category < $1.category }

        return (sexData, raceData)
    }
    
    
    func fetchData<T: Decodable>(fromUrl urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            print("API Error: Status Code \(statusCode)")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Generic error during fetch or decode: \(error.localizedDescription)")
            throw error
        }
    }
}

func monthYearStringToDate(_ monthYearString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-yyyy"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter.date(from: monthYearString)
}
