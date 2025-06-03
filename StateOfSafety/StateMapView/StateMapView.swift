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
                                viewModel.selectedState = state
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    StateMapView()
}
