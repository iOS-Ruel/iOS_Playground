//
//  Order.swift
//  Albertos
//
//  Created by Jungman Bae on 7/12/24.
//

import Foundation

struct Order: Equatable {
    let items: [MenuItem]
    var total: Double {
        items.reduce(0) { previousReduceValue, currentMenuItem in
            previousReduceValue + currentMenuItem.price
        }
    }
}
