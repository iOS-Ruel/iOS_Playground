//
//  ContentView.swift
//  JRNL_SwiftUI
//
//  Created by Chung Wussup on 5/28/24.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        TabView{
            JournalListView()
                .tabItem {
                    Label("Journal", systemImage: "list.bullet")
                }
            
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
