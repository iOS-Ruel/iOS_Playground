//
//  MainResModel.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import Foundation

protocol BasedItem: Codable {}

struct BasedRes<T: BasedItem>: Codable {
    let header: BasedHeader
    let body: BasedBody<T>
}

struct BasedHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct BasedBody<T: BasedItem>: Codable {
    let items: BasedItems<T>
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct BasedItems<T: BasedItem>: Codable {
    let item: [T]
}
