//
//  Diets.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import Foundation
// MARK: - Diets

struct Diets: Codable {
    let id: Int
    let name, tool_tip: String
    var isChecked : Bool? = false
}


struct DietsList: Codable {
    let data: [Diets]
}

