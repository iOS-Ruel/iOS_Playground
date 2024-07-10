//
//  HelloWorldTests.swift
//  HelloWorldTests
//
//  Created by Chung Wussup on 7/10/24.
//

import XCTest
@testable import HelloWorld


func isLeap(_ year: Int) -> Bool {
    guard year % 400 != 0 else { return true }
    guard year % 100 != 0 else { return false }
    return year % 4 == 0
}

final class HelloWorldTests: XCTestCase {
    //    LeapYearTest
    func testEvenlyDivisibleBy4IsLeap() {
//        XCTAssertTrue(isLeap(2020))
        
        
        //3가지 과정을가짐
        let year = 2020 // arrange: 입력준비
        let leap = isLeap(year) // Act: 테스트 대상 실행
        XCTAssertTrue(leap) // Assert: 출력
    }
    
    func testEvenlyDivisibleBy100IsNotLeap() {
        XCTAssertFalse(isLeap(2100))
    }
    
    func testEvenlyDivisibleBy400IsLeap() {
        XCTAssertTrue(isLeap(2000))
    }
    
    func testNotEvenlyDivisibleBy4Or400IsNotLeap() {
        XCTAssertFalse(isLeap(2021))
    }
    
}
