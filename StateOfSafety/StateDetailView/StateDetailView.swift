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
        
        VStack {
            Text(selectedState.name)
        }
        .navigationTitle(selectedState.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMonthlyCrimeCounts(offenseCode: "BUR")
        }
    }
}

#Preview {
    StateDetailView(state: StateData(
        id: 1001,
        name: "Alabama",
        abbreviation: "AL",
        latitude: 32.8067,
        longitude: -86.7911)
    )
}
