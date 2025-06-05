//
//  CrimeType.swift
//  StateOfSafety
//
//  Created by Nhi Ngo on 6/5/25.
//

import Foundation

struct CrimeType: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let abbr: String
    let code: Int
}
