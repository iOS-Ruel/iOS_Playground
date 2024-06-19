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

struct APIErrorMessage: Decodable {
  var error: Bool
  var reason: String
}
enum NetworkError: Error {
    case transporError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

enum APIError: LocalizedError {
    case invalidRequestError(String)
    case transportError(Error)
    case invalidResponse
    case validationError(String)
    case decodingError(Error)
}

class AuthenticationService {
    func checkUserNameAvailable(userName: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "http://localhost:8080/isUserNameAvailable?userName=\(userName)") else {
            return Fail(error: APIError.invalidRequestError("URL Invalid"))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> Error in
                return APIError.transportError(error)
            }
            .tryMap { (data, response) -> (data: Data, reponse: URLResponse) in
                print("Receive response from server, now checking status code")
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                if (200..<300) ~= urlResponse.statusCode {
                } else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(APIErrorMessage.self, from: data)
             
                    if urlResponse.statusCode == 400 {
                        throw APIError.validationError(apiError.reason)
                    }
                    
                    if (500..<600) ~= urlResponse.statusCode {
                        let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                        //TODO: SERVER ERROR HANDLING
                    }
                }
                return (data, response)
            }
            .map(\.data)
            .decode(type: UserNameAvailableMessage.self, decoder: JSONDecoder())
            .map(\.isAvailable)
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
