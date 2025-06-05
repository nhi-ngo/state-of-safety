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
    @State private var selectedDemographicType: DemographicsType = .sex

    
    init(state: StateData) {
        self.selectedState = state
        self._viewModel = State(initialValue: StateDetailViewModel(state: state))
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            CrimeTypePicker(selectedCrime: $viewModel.selectedCrime)
                .onChange(of: viewModel.selectedCrime) {
                    viewModel.fetchDataForSelectedCrime()
                }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Offense Counts Reported Last 3 Years")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    // --- Line chart section ---
                    OffenseLineChart(
                        data: viewModel.chartData
                    )
                    
                    // --- Bar chart section ---
                    Text("Arrestee Demographics")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    Picker("Selected Demographic Type", selection: $selectedDemographicType) {
                        ForEach(DemographicsType.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .padding(.bottom, 10)
                    .pickerStyle(.segmented)
                    
                    VStack {
                        if let errorMsg = viewModel.chartErrorMessage {
                            Text(errorMsg)
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 280, alignment: .center)
                        } else {
                            switch selectedDemographicType {
                            case .sex:
                                DemographicsBarChart(
                                    data: viewModel.arrestSexData
                                )
                            case .race:
                                DemographicsBarChart(
                                    data: viewModel.arrestRaceData
                                )
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("\(selectedState.name), \(selectedState.abbreviation)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchDataForSelectedCrime()
        }
    }
}

#Preview {
    StateDetailView(state: MockData().mockState)
}
