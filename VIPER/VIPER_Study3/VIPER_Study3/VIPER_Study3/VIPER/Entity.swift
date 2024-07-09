//
//  Entity.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import Foundation


struct Pokemon: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [PokeResults]
}

struct PokeResults: Codable {
    let name: String
    let url: String
}
