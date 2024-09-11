//
//  MenuRow.ViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 7/11/24.
//

extension MenuRow {
    struct ViewModel {
        let text: String
        
        init(item: MenuItem) {
            text = item.spicy ? "\(item.name) 🌶" : item.name
        }
    }
}
