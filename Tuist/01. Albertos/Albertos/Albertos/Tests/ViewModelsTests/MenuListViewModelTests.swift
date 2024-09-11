//
//  MenuListViewModelTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/11/24.
//

import XCTest
import Combine

@testable import Albertos


struct TestError: Error, Equatable {
    let id: Int
}

final class MenuListViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testCallsGivenGroupingFunction() throws {
        try XCTSkipIf(true, "skipping this for now, keeping it to reuse part of the code later on")

        var called = false
        let inputSections = [MenuSection.fixture()]
        let _: ([MenuItem]) -> [MenuSection] = { _ in
            called = true
            return inputSections
        }
        
//        let viewModel = MenuList.ViewModel(menu: [.fixture()], menuGrouping: probeClosure)
//        let sections = viewModel.sections
        
        // Check that the given closure was called
        XCTAssertTrue(called)
        // Check that the returned value was build with the closure
//        XCTAssertEqual(sections, inputSections)
    }
    
    func testWhenFetchingStartsPublishesEmptyMenu() throws {
        let viewModel = MenuList.ViewModel(menuFetching: MenuFetchingStub(returning: .success([.fixture()])))
        let sections = try viewModel.sections.get()
        XCTAssertTrue(sections.isEmpty)
    }
    
    func testWhenSucceedsFetchingSectionsReceivedMenuAndGivenGroupingClosure() throws {

        var receivedMenu: [MenuItem]?
        let expectedSections: [MenuSection] = [.fixture()]
        
        let spyClosure: ([MenuItem]) -> [MenuSection] = { items in
            receivedMenu = items
            return expectedSections
        }
        
        let expectedMenu: [MenuItem] = [.fixture()]
        let menuFetchingStub = MenuFetchingStub(returning: .success(expectedMenu))
        
        let viewModel = MenuList.ViewModel(
            menuFetching: menuFetchingStub,
            menuGrouping: spyClosure
        )
        
        let expectation = XCTestExpectation(
            description: "받은 메뉴와 주어진 그룹화 클로저를 사용하여 생성된 섹션들을 발행합니다.")
        
        viewModel.$sections
            .dropFirst()
            .sink { value in
                guard case .success(let sections) = value else {
                    return XCTFail("Expected a successful Result, got: \(value)")
                }

                XCTAssertEqual(receivedMenu, expectedMenu)
                XCTAssertEqual(sections, expectedSections)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWhenFetchingFailsPublishesAnError() {
        let expectedError = TestError(id: 123)
        let menuFetchingStub = MenuFetchingStub(returning: .failure(expectedError))
        
        let viewModel = MenuList.ViewModel(
            menuFetching: menuFetchingStub,
            menuGrouping: { _ in [] }
        )
        let expectation = XCTestExpectation(description: "에러를 발행함")
        
        viewModel
            .$sections
            .dropFirst()
            .sink { value in
                guard case .failure(let error) = value else {
                    return XCTFail("Expected a failing Result, got: \(value)")
                }
                
                XCTAssertEqual(error as? TestError, expectedError)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
