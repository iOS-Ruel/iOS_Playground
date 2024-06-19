//
//  PlaceDetailService.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/19/24.
//

import Foundation
import Combine


struct PlaceDetailService {
    func getLocationImageList<T: BasedItem>(contentId: String,
                                            type: T.Type) -> AnyPublisher<ApiResponse<T>, Error> {
        
        guard let apiKey = Bundle.main.apiKey else {
            print("API 키를 로드하지 못했습니다.")
            return Fail(error: URLError(.unknown))
                .eraseToAnyPublisher()
        }
        
        var urlComponents = URLComponents(string: APIURL.imageList.urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "MobileOS", value: "IOS"),
            URLQueryItem(name: "MobileApp", value: "TrekKo"),
            URLQueryItem(name: "serviceKey", value: apiKey),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId)
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
    }
}
