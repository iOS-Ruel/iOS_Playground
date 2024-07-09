//
//  Mood.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import Foundation

enum Mood: String, Codable, CaseIterable {
    case bad
    case notGreat
    case okay
    case good
    case great
    
    
    var imageName: String {
        switch self  {
        case .bad: return "cloud.bolt.rain.fill"
        case .notGreat: return "cloud.heavyrain.fill"
        case .okay: return "cloud.fill"
        case .good: return "cloud.sun.fill"
        case .great: return "sun.max.fill"
        }
    }
    
    var name: String {
        switch self  {
        case .bad: return "Bad"
        case .notGreat: return "Not\nGreat"
        case .okay: return "Okay"
        case .good: return "Good"
        case .great: return "Great"
        }
    }
    
}
