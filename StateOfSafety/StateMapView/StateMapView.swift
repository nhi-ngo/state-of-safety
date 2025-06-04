//
//  StateMapView.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI
import MapKit

struct StateMapView: View {
    
    @State var viewModel = StateMapViewModel()
    
    @State var selectedState: StateData?
    @State var isShowingStateDetailView = false
        
    var body: some View {
        VStack {
            Map(position: $viewModel.cameraPosition) {
                ForEach(viewModel.states) { state in
                    Annotation(state.name, coordinate: state.coordinate) {
                        Image(systemName: "mappin")
                            .font(.title2)
                            .foregroundStyle(.red)
                            .background(Circle().fill(.white.opacity(0.6)).scaleEffect(1.5))
                            .onTapGesture {
                                selectedState = state
                                isShowingStateDetailView = true
                            }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingStateDetailView) {
            NavigationStack {
                if let selectedState = selectedState {
                    StateDetailView(state: selectedState)
                        .toolbar {
                            Button("Dismiss") {
                                isShowingStateDetailView = false
                            }
                        }
                } else {
                    Text("Error: No state selected.")
                }
            }
        }
    }
}

#Preview {
    StateMapView()
}
