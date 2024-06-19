//
//  MainMapViewService.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import Foundation
import Combine

enum APIURL {
    case baseList
    case locationBasedList
    case searchList
    case imageList
    case basedSyncList
    
    var urlString: String {
        let baseURL = "https://apis.data.go.kr/B551011/GoCamping"
        
        switch self {
        case .baseList:
            return baseURL + "/basedList"
        case .locationBasedList:
            return baseURL + "/locationBasedList"
        case .searchList:
            return baseURL + "/searchList"
        case .imageList:
            return baseURL + "/imageList"
        case .basedSyncList:
            return baseURL + "/basedSyncList"
        }
    }
    
}

class MainMapViewService {
    
    func getLocationBasedList<T: BasedItem>(mapX: String, mapY: String, radius: String, 
                                            type: T.Type) -> AnyPublisher<ApiResponse<T>, Error> {
        
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: URLError(.unknown))
                .eraseToAnyPublisher()
        }
        
        
        var urlComponents = URLComponents(string: APIURL.locationBasedList.urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "numOfRows", value: "1000"),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "TrekKo"),
            URLQueryItem(name: "serviceKey", value: apiKey),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "mapX", value: mapX),
            URLQueryItem(name: "mapY", value: mapY),
            URLQueryItem(name: "radius", value: radius)
        ]
        
        guard let url = urlComponents?.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var urlString = url.absoluteString
        urlString = urlString.replacingOccurrences(of: "%25", with: "%")
        
        guard let url = URL(string:urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print("Debug: Received Data - \(String(data: data, encoding: .utf8) ?? "")")
                return data
            }
            .decode(type: ApiResponse<T>.self, decoder: JSONDecoder())
            .mapError { error in
                print("Debug: Decoding Error - \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
//        return URLSession.shared.dataTaskPublisher(for: url)
//                   .tryMap { (data, response) -> Data in
//                       guard let httpResponse = response as? HTTPURLResponse,
//                             httpResponse.statusCode == 200 else {
//                           throw URLError(.badServerResponse)
//                       }
////                       print("Debug: Received Data - \(String(data: data, encoding: .utf8) ?? "")")
//                       return data
//                   }
//                   .tryMap { data -> ApiResponse<T> in
//                       // JSON 데이터 출력
//                       if let jsonString = String(data: data, encoding: .utf8) {
//                           print("Debug: JSON String - \(jsonString)")
//                       }
//                       
//                       do {
//                           let decodedData = try JSONDecoder().decode(ApiResponse<T>.self, from: data)
//                           return decodedData
//                       } catch let decodingError {
//                           print("Debug: Decoding Error - \(decodingError)")
//                           throw decodingError
//                       }
//                   }
//                   .mapError { error in
//                       print("Debug: Decoding Error - \(error.localizedDescription)")
//                       return error
//                   }
//                   .eraseToAnyPublisher()
    }
    
    
    
}
