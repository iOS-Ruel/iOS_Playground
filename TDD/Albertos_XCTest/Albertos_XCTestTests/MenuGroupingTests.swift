//
//  Albertos_XCTestTests.swift
//  Albertos_XCTestTests
//
//  Created by Chung Wussup on 7/10/24.
//

import XCTest
@testable import Albertos_XCTest

extension Array {
    subscript(safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

final class MenuGroupingTests: XCTestCase {
    func testMenuWithManyCategoresReturnsOneSectionPerCategory() {
        
    }
    
    func testMenuWithOneCategoryReturnOneSection() {
        //메뉴아이템이 동일한 카테고리를 갖는 경우 하나의 섹션으로 구분
        let menu = [
            MenuItem(category: "pastas", name: "a pasta"),
            MenuItem(category: "drinks", name: "a drink"),
            MenuItem(category: "desserts", name: "a dessert"),
            MenuItem(category: "pastas", name: "another pasta"),
        ].shuffled()
        let sections = groupMenuByCategory(menu)
        XCTAssertEqual(sections.count, 3)
        XCTAssertEqual(sections[safe: 0]?.category, "pastas")
        // XCTAssertEqual failed: // ("Optional("")") is not equal to ("Optional("pastas")")
        XCTAssertEqual(sections[safe: 1]?.category, "drinks")
        // XCTAssertEqual failed: // ("nil") is not equal to ("Optional("drinks")")
        XCTAssertEqual(sections[safe: 2]?.category, "desserts")
        // XCTAssertEqual failed: // ("nil") is not equal to ("Optional("desserts")")
    }
    
    func testEmptyMenuReturnsEmptySections() {
        let menu = [MenuItem]()
        let sections = groupMenuByCategory(menu)
        XCTAssertTrue(sections.isEmpty)
    }
    
    
    
    
    
    //    override func setUpWithError() throws {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDownWithError() throws {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    //
    //    func testExample() throws {
    //        // This is an example of a functional test case.
    //        // Use XCTAssert and related functions to verify your tests produce the correct results.
    //        // Any test you write for XCTest can be annotated as throws and async.
    //        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
    //        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //    }
    //
    //    func testPerformanceExample() throws {
    //        // This is an example of a performance test case.
    //        self.measure {
    //            // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
