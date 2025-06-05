//
//  OnboardingView.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/5/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboardingCompleted") var onboardingCompleted: Bool = false
    
    var body: some View {
        VStack {
            Image("hero")
                .resizable()
                .scaledToFill()
            
            Text("Welcome to State of Safety!")
                .font(.title2.bold())
            
            Text("SOS app displays historical US state-level data from the FBI Crime Data API to show trends for several types of crimes.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.vertical, 15)

            
            Button {
                onboardingCompleted = true
            } label: {
                Text("Explore Interactive Map")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.accent)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
