//
//  ContentView.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        if onboardingCompleted {
            StateMapView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}
