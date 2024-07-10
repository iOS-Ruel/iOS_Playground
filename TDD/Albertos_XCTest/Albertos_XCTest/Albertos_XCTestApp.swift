//
//  Albertos_XCTestApp.swift
//  Albertos_XCTest
//
//  Created by Chung Wussup on 7/10/24.
//

import SwiftUI

@main
struct Albertos_XCTestApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(section: groupMenuByCategory(menu))
                    .navigationTitle("Alberto's 🇲🇽")
            }
        }
    }
}

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad"),
    MenuItem(category: "starters", name: "Arancini Balls"),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata"),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara"),
    MenuItem(category: "drinks", name: "Water"),
    MenuItem(category: "drinks", name: "Red Wine"),
    MenuItem(category: "desserts", name: "Tiramisù"),
    MenuItem(category: "desserts", name: "Crema Catalana"),
]
