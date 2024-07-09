//
//  MoodDiaryStorage.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import Foundation

final class MoodDiaryStorage {
    
    func persist(_ items: [MoodDiary]) {
        Storage.store(items, to: .documents, as: "diary_list.json")
    }
    
    func fetch() -> [MoodDiary] {
        let list = Storage.retrive("diary_list.json", from: .documents, as: [MoodDiary].self) ?? []
        return list
    }
}
