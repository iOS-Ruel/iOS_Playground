//
//  AuthenticationService.swift
//  SignUpForm+Combine
//
//  Created by Chung Wussup on 6/19/24.
//

import Foundation
import Combine

struct UserNameAvailableMessage: Codable {
    let isAvailable: Bool
    let userName: String
}

enum NetworkError: Error {
    case transporError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

class AuthenticationService {
    func checkUserNameAvailableWithClosure(userName: String) -> AnyPublisher<Bool, Never> {
        guard let url = URL(string: "http://localhost:8080/isUserNameAvailable?userName=\(userName)") else {
            return Just(false).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, reseponse in
                do {
                    let decoder = JSONDecoder()
                    let userAvailableMessage = try decoder.decode(UserNameAvailableMessage.self, from: data)
                    return userAvailableMessage.isAvailable
                } catch {
                    return false
                }
            }
            .replaceError(with: false)
            .eraseToAnyPublisher()
    }
    
    //    func checkUserNameAvailableWithClosure(userName: String, completion: @escaping(Result<Bool,NetworkError>) -> Void) {
    //        let url = URL(string: "http://localhost:8080/isUserNameAvailable?userName=\(userName)")!
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let error = error {
    //                completion(.failure(.transporError(error)))
    //                return
    //            }
    //
    //            if let response = response as? HTTPURLResponse,
    //               !(200..<300).contains(response.statusCode) {
    //                completion(.failure(.serverError(statusCode: response.statusCode)))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.noData))
    //                return
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                let userAvaliableMessage = try decoder.decode(UserNameAvailableMessage.self, from: data)
    //                completion(.success(userAvaliableMessage.isAvailable))
    //            } catch {
    //                completion(.failure(.decodingError(error)))
    //            }
    //        }
    //
    //        task.resume()
    //
    //    }
}
