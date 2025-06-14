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
    
    @State var selectedState: StateData? = nil
    
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
                            }
                    }
                }
            }
        }
        .sheet(item: $selectedState) { state in
            NavigationStack {
                StateDetailView(state: state)
                    .toolbar {
                        Button("Dismiss") {
                            selectedState = nil
                        }
                    }
            }
        }
    }
}

#Preview {
    StateMapView()
}
