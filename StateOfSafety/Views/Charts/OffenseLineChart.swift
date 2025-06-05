//
//  OffenseLineChart.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import SwiftUI
import Charts

struct OffenseLineChart: View {
    
    let data: [MonthlyChartData]
    
    @State private var selectedDate: Date?
    @State private var selectedValue: Double?
    
    var body: some View {
        VStack(alignment: .leading) {
            if data.isEmpty {
                Text("No data available.")
                    .foregroundColor(.secondary)
                    .frame(height: 200, alignment: .center)
            } else {
                Chart {
                    ForEach(data.sorted { $0.date < $1.date }) { point in
                        LineMark(
                            x: .value("Month", point.date, unit: .month),
                            y: .value("Count", point.value)
                        )
                        .foregroundStyle(.cyan)
                        .interpolationMethod(.catmullRom)
                        
                        PointMark(
                            x: .value("Month", point.date, unit: .month),
                            y: .value("Count", point.value)
                        )
                        .foregroundStyle(.cyan)
                        .symbolSize(selectedDate == point.date ? 100 : 30)
                    }
                    
                    if let selectedDate = selectedDate, let value = selectedValue {
                        RuleMark(x: .value("Selected data point", selectedDate, unit: .month))
                            .foregroundStyle(Color.gray.opacity(0.5))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [3, 3]))
                            .annotation(position: .automatic, alignment: .leading, spacing: 2) {
                                VStack(alignment: .leading, spacing: 3) {
                                    Text(selectedDate.formatted(Date.FormatStyle().month(.twoDigits).year(.defaultDigits)))
                                        .font(.caption.bold())
                                    Text("Count: \(value.formatted(.number.grouping(.automatic)))")
                                        .font(.caption)
                                }
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 5).fill(.white)
                                )
                                .shadow(radius: 2)
                            }
                    }
                }
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        guard let plotFrame = proxy.plotFrame else {
                                            return
                                        }
                                        
                                        let startX = geometry[plotFrame].origin.x
                                        let currentX = value.location.x - startX
                                        
                                        if let plotDate: Date = proxy.value(atX: currentX) {
                                            updateSelection(for: plotDate)
                                        }
                                    }
                            )
                    }
                }
                .frame(minHeight: 250)
                .onChange(of: data.map { $0.id }) {
                    print("OffenseLineChart: Data changed, clearing selection.")
                    selectedDate = nil
                    selectedValue = nil
                }
            }
        }
    }
    
    private func updateSelection(for plotDate: Date) {
        let calendar = Calendar.current
        let targetComponents = calendar.dateComponents([.year, .month], from: plotDate)
        guard let snappedDate = calendar.date(from: targetComponents) else { return }
        self.selectedDate = snappedDate
        
        // Find the point that exactly matches the snapped month and year
        if let point = data.first(where: {
            let pointComponents = calendar.dateComponents([.year, .month], from: $0.date)
            return pointComponents == targetComponents
        }) {
            self.selectedValue = point.value
        } else {
            self.selectedValue = nil // No data point for this exact month
        }
    }
}

#Preview {
    OffenseLineChart(data: MockData().monthlyCounts)
        .frame(height: 250)
}
