//
//  ImageLoader.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/17/24.
//

import UIKit


struct ImageLoader {
    static func loadImageFromUrl(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(UIImage(systemName: "questionmark"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(UIImage(systemName: "questionmark"))
            }
        }.resume()
    }
}
