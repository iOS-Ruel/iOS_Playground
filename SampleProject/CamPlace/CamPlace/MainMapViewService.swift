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
        let baseURL = "https://apis.data.go.kr/B551011/GoCamping/basedSyncList"
        
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
    
    var cancellables = Set<AnyCancellable>()
    
    func getLocationBasedList<T: BasedItem>(mapX: String, mapY: String, radius: String, langCode: String, type: T.Type) -> AnyPublisher<BasedRes<T>, Error> {
//        guard let apiKey = Bundle.main.apiKey else {
//            print("API 키를 로드하지 못했습니다.")
//            return Fail(error: URLError(.unknown))
//                .eraseToAnyPublisher()
//        }
        
        
        var urlComponents = URLComponents(string: "https://apis.data.go.kr/B551011/Odii/themeLocationBasedList")
        urlComponents?.queryItems = [
            URLQueryItem(name: "numOfRows", value: "177"),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "TrekKo"),
            URLQueryItem(name: "serviceKey", value: "5uyQuJMH%2FNR%2FnDrDpK8piq1ET7tUg1306jFCxKjT1wRtpfU5t1%2BWeBMzSrJE%2BCEq%2FLUlazCy3IYaglcaLl3CBA%3D%3D"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "mapX", value: mapX),
            URLQueryItem(name: "mapY", value: mapY),
            URLQueryItem(name: "radius", value: radius),
            URLQueryItem(name: "langCode", value: langCode)
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
                return data
            }
            .decode(type: BasedRes<T>.self, decoder: JSONDecoder())
            .mapError { error in
                print("Debug: Decoding Error - \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
    
    
    
}
