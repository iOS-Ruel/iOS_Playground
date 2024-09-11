//
//  MenuFetcherTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/12/24.
//

import XCTest
import Combine

@testable import Albertos

final class MenuFetcherTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testWhenRequestSucceedsPublishesDecodedMenuItems() throws {
        let json = """
[
    { "name": "a name", "category": "a category", "spicy": true, "price": 1.0 },
    { "name": "another name", "category": "a category", "spicy": true, "price": 1.0 }
]
"""
        let data = try XCTUnwrap(json.data(using: .utf8))
        
        let stub = NetworkFetchingStub(returning: .success(data))
        let menuFetcher = MenuFetcher(networkFetching: stub)
        let expectation = XCTestExpectation(description: "Publishes decoded [MenuItem]")
        
        menuFetcher.fetchMenu()
            .sink(receiveCompletion: { _ in }, receiveValue: {
                items in
                // TODO: items 값이 올바른지 테스트
                XCTAssertEqual(items.count, 2)
                XCTAssertEqual(items.first?.name, "a name")
                XCTAssertEqual(items.last?.name, "another name")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    func testWhenRequestFailsPublishesReceivedError() {}
}
