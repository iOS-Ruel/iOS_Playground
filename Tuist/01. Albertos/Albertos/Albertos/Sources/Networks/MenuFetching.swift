//
//  MenuFetching.swift
//  Albertos
//
//  Created by Jungman Bae on 7/11/24.
//

import Combine

protocol MenuFetching {
    func fetchMenu() -> AnyPublisher<[MenuItem], Error>
}
