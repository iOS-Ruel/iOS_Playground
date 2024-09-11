//
//  MenuFetchingStub.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/11/24.
//

import Foundation
import Combine

@testable import Albertos

class MenuFetchingStub: MenuFetching {
    let result: Result<[MenuItem], Error>
    
    init(returning result: Result<[MenuItem], Error>) {
        self.result = result
    }
    
    func fetchMenu() -> AnyPublisher<[MenuItem], any Error> {
        return result.publisher
            .delay(for: 0.1, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

