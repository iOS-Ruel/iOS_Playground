//
//  CoreData_SampleApp.swift
//  CoreData_Sample
//
//  Created by Chung Wussup on 7/2/24.
//

import SwiftUI

@main
struct CoreData_SampleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
