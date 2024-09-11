//
//  MenuItemTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/12/24.
//

import XCTest

@testable import Albertos

final class MenuItemTests: XCTestCase {
    func testWhenDecodedFromJSONDataHasAllTheInputProperties() throws {
        // Arrange
        let json = #"{ "name": "a name", "category": "a category", "spicy": true, "price": 1.0 }"#
        let jsonData = try XCTUnwrap(json.data(using: .utf8))
        
        // Act
        let item = try JSONDecoder().decode(MenuItem.self, from: jsonData)
        
        // Assert
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
    }
    
    func testDecodesFromJSONData() throws {
        // Arrange
        let data = try dataFromJSONFileNamed("menu_item")

        // Act
        let item = try JSONDecoder().decode(MenuItem.self, from: data)

        // Assert
        XCTAssertEqual(item.name, "a name")
        XCTAssertEqual(item.category, "a category")
        XCTAssertEqual(item.spicy, true)
    }
}
