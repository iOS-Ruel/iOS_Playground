//
//  ContentView.swift
//  Albertos_XCTest
//
//  Created by Chung Wussup on 7/10/24.
//

import SwiftUI

struct MenuList: View {
    let section: [MenuSection]
    
    var body: some View {
        List {
            ForEach(section) { section in
                Section(header: Text(section.category)) {
                    ForEach(section.items) { item in
                        Text(item.name)
                    }
                }
            }
        }
    }
}

#Preview {
    MenuList(section: groupMenuByCategory(menu))
}
