//
//  DiaryListViewModel.swift
//  SwiftUI_DiarySample
//
//  Created by Chung Wussup on 3/31/24.
//

import Foundation
import Combine

final class DiaryListViewModel: ObservableObject {
    
    let storage: MoodDiaryStorage
    
    @Published var list: [MoodDiary] = []
    @Published var dic: [String : [MoodDiary]] = [:]
    
    var subscriptions = Set<AnyCancellable>()
    //데이터 파일에서 다이어리 리스트 가져오기
    //리스트에 해당 일기 객체 셋팅
    //리스트 셋팅 되면 dic도 셋팅
    
    init(storage: MoodDiaryStorage) {
        self.storage = storage
        bind()
    }
    
    //dic의 key
    var keys: [String] {
        return dic.keys.sorted{ $0 < $1 }
    }
    
    private func bind() {
        $list.sink { items in
            print("list changed -> ",items)
            self.dic = Dictionary(grouping: items, by: { $0.monthlyIdentifier } )
            self.persist(items: items)
        }.store(in: &subscriptions)
    }
    
    //저장
    func persist(items: [MoodDiary]) {
        guard items.isEmpty == false else { return }
        
        self.storage.persist(items)
    }
    
    func fetch() {
        self.list = storage.fetch()
    }
    
}
