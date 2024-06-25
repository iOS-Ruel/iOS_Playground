//
//  WeatherData.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//

import Foundation


struct WeatherData: Codable {
    let temperature: Double
    let description: String
    let humidity: Double
    let windSpeed: Double
}
