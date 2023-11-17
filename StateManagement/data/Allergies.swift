//
//  Allergies.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import Foundation


struct Allergies: Codable {
    let id: Int
    let name: String
}

struct AllergiesList: Codable {
    let data: [Allergies]
}

