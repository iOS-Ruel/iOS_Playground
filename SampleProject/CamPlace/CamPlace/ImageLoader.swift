//
//  ImageLoader.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/17/24.
//

import UIKit
import Combine

struct ImageLoader {
//    static func loadImageFromUrl(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
//        guard let url = URL(string: urlString) else {
//            completion(UIImage(systemName: "questionmark"))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data, let image = UIImage(data: data) {
//                completion(image)
//            } else {
//                completion(UIImage(systemName: "questionmark"))
//            }
//        }.resume()
//    }
    
    static func loadImageFromUrl(_ urlString: String) -> AnyPublisher<UIImage?, Never> {
         guard let url = URL(string: urlString) else {
             return Just(UIImage(systemName: "questionmark"))
                 .eraseToAnyPublisher()
         }
         
         return URLSession.shared.dataTaskPublisher(for: url)
             .map { data, response in
                 return UIImage(data: data)
             }
             .catch { _ in
                 Just(UIImage(systemName: "questionmark"))
             }
             .eraseToAnyPublisher()
     }
}
