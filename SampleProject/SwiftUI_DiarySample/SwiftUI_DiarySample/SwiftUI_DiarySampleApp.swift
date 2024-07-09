//
//  SwiftUI_DiarySampleApp.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import SwiftUI

@main
struct SwiftUI_DiarySampleApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = DiaryListViewModel(storage: MoodDiaryStorage())
            DiaryListView(vm: vm)
        }
    }
}
