//
//  DemographicsBarChart.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import SwiftUI
import Charts

struct DemographicsBarChart: View {
    
    let data: [BarChartSegment]
    
    init(data: [BarChartSegment]) {
        self.data = data.sorted { $0.category < $1.category }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if data.isEmpty {
                Text("No data available.")
                    .foregroundColor(.secondary)
                    .frame(height: 200, alignment: .center)
            } else {
                Chart(data) { segment in
                    BarMark(
                        x: .value("Category", segment.category.prefix(15) + (segment.category.count > 15 ? "..." : "")), // Truncate long category names for X-axis
                        y: .value("Count", segment.value)
                    )
                    .foregroundStyle(segment.color)
                    .cornerRadius(4)
                    .annotation(position: .top, alignment: .center, spacing: 2) {
                        Text(segment.value.formatted(.number.grouping(.automatic)))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                .chartXAxis {
                    AxisMarks(preset: .aligned) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(orientation: .vertical).font(.caption)
                    }
                }
                .chartYAxis {
                    AxisMarks(preset: .automatic, values: .automatic(desiredCount: 6)) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                .frame(minHeight: 250)
            }
        }
    }
}

#Preview {
    VStack {
        Text("Demographics Charts").font(.title)
        DemographicsBarChart(data: MockData().mockRaceData)
        DemographicsBarChart(data: MockData().mockSexData)
    }
    .padding()
}
