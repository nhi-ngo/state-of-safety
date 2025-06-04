//
//  StateDetailView.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI

struct StateDetailView: View {
    
    let selectedState: StateData
    @State private var viewModel: StateDetailViewModel
    
    init(state: StateData) {
        self.selectedState = state
        self._viewModel = State(initialValue: StateDetailViewModel(state: state))
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Offense Counts Reported Last 5 Years")
                    .font(.headline)
                    .padding(.top, 20)
                
                OffenseLineChart(
                    data: viewModel.chartData
                )
            }
        }
        .padding()
        .navigationTitle("\(selectedState.name), \(selectedState.abbreviation)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMonthlyCrimeCounts(offenseCode: "BUR")
        }
    }
}

#Preview {
    StateDetailView(state: MockData().mockState)
}
