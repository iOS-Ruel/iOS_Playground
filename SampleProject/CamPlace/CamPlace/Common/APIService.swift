//
//  APIService.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/24/24.
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

enum APIError: Error  {
    case apiKeyError
    case urlError
    case stringURLError
    case httpError
    case decodeError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .apiKeyError:
            return NSLocalizedString("Description of invalid API KEY", comment: "Invalid APIKEY")
        case .urlError:
            return NSLocalizedString("Description of invalid URL", comment: "Invalid URL")
        case .stringURLError:
            return NSLocalizedString("Description of invalid URL String", comment: "Invalid URL String")
        case .httpError:
            return NSLocalizedString("Description of invalid HTTP Code", comment: "Invalid HTTP State Code")
        case .decodeError:
            return NSLocalizedString("Description of invalid Decode", comment: "Invalid Decode")
        }
    }
}


class APIService {
    
    func getLocationBasedList<T: BasedItem>(mapX: String, mapY: String, radius: String,
                                            type: T.Type) -> AnyPublisher<ApiResponse<T>, APIError> {
        
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            print(APIError.apiKeyError.localizedDescription)
            return Fail(error: .apiKeyError)
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
            return Fail(error: .urlError)
                .eraseToAnyPublisher()
        }
        
        var urlString = url.absoluteString
        urlString = urlString.replacingOccurrences(of: "%25", with: "%")
        
        guard let url = URL(string:urlString) else {
            return Fail(error: .stringURLError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw APIError.httpError
                }
//                print("Debug: Received Data - \(String(data: data, encoding: .utf8) ?? "")")
                return data
            }
            .decode(type: ApiResponse<T>.self, decoder: JSONDecoder())
            .mapError { error in
                print("Debug: Decoding Error - \(error.localizedDescription)")
                return APIError.decodeError
            }
            .eraseToAnyPublisher()
    }
    
    
    
}
