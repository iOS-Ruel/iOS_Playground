//
//  XCTestCase+JSON.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/12/24.
//

import XCTest

extension XCTestCase {
    func dataFromJSONFileNamed(_ name: String) throws -> Data {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: "menu_item", withExtension: "json")
        )
        return try Data(contentsOf: url)
    }
}
