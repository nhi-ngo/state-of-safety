//
//  ChartAnnotationView.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/5/25.
//

import SwiftUI
import Charts

struct ChartAnnotationView: View {
    
    let date: Date
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(date.formatted(Date.FormatStyle().month(.twoDigits).year(.defaultDigits)))
                .font(.caption.bold())
                .foregroundStyle(.black)
            Text("Count: \(value.formatted(.number.grouping(.automatic)))")
                .font(.caption)
                .foregroundStyle(.black)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 5).fill(.white)
        )
        .shadow(radius: 2)
    }
}

#Preview {
    ChartAnnotationView(date: Date(), value: 100)
}
