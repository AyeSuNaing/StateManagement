//
//  HealthConcerns.swift
//  StateManagement
//
//  Created by AyeSuNaing on 12/11/2023.
//

import Foundation

struct HealthConcern: Codable {
    let id: Int
    let name: String
    var isSelect : Bool? = false
}



struct HealthConcernList: Codable {
    let data: [HealthConcern]
}

