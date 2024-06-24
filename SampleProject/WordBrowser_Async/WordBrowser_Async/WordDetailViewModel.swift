//
//  WordDetailViewModel.swift
//  WordBrowser_Async
//
//  Created by Chung Wussup on 6/24/24.
//

import Foundation
import Combine

class WordDetailViewModel: ObservableObject {
    @Published private var result = Word.empty
    @Published var isSearching = false
    @Published var definitions = [Definition]()
    
    
    
}
