//
//  MenuSection.swift
//  Albertos_XCTest
//
//  Created by Chung Wussup on 7/10/24.
//

import Foundation

struct MenuSection: Identifiable {
    var id: String { category }
    
    let category: String
    let items: [MenuItem]
    
}
