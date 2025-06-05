//
//  CrimePicker.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/4/25.
//

import SwiftUI


let crimeTypes: [CrimeType] = [
    CrimeType(name: "Burglary", abbr: "BUR", code: 60),
    CrimeType(name: "Robbery", abbr: "ROB", code: 30),
    CrimeType(name: "Larceny", abbr: "LAR", code: 70)
]

struct CrimeTypePicker: View {
    @Binding var selectedCrime: CrimeType
    
    var body: some View {
        Picker("Select Crime Type", selection: $selectedCrime) {
            ForEach(crimeTypes) { crimeType in
                Text(crimeType.name).tag(crimeType)
            }
        }
        .pickerStyle(.segmented)
    }
}
#Preview {
    CrimeTypePicker(selectedCrime: .constant(crimeTypes[0]))
}

