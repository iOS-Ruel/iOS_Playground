//
//  Forecast.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/26/24.
//

import Foundation


struct DayForecast: Identifiable {
    var id = UUID().uuidString
    var day: String
    var farenheit: CGFloat
    var image: String
}

var forecast = [
    DayForecast(day: "Today", farenheit: 12, image: "sun.min"),
    DayForecast(day: "wed", farenheit: 123, image: "cloud.sun"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "thu", farenheit: 14, image: "sun.max"),
    DayForecast(day: "fry", farenheit: 14, image: "cloud.sun")
]
