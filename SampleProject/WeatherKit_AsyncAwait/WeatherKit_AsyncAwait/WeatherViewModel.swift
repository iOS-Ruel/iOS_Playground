//
//  WeatherViewModel.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//


import Foundation
import CoreLocation
import WeatherKit

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherData?
    @Published var dailyWeather: [DayWeatherData] = []
    @Published var hourWeather: [DayWeatherData] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    @MainActor
    func fetchWeathers(for location: CLLocation) async throws {
        try await fetchWeather(for: location)
        try await getDailyForecast(for: location)
        try await getHourForecast(for: location)
    }
    
    @MainActor
    func fetchWeather(for location: CLLocation) async throws {
        self.isLoading = true
        
        do {
            let currentWeather = try await WeatherService.shared.weather(for: location).currentWeather
            self.weather = WeatherData(temperature: currentWeather.temperature.value,
                                       description: currentWeather.condition.description,
                                       humidity: currentWeather.humidity,
                                       windSpeed: currentWeather.wind.speed.value)
            self.isLoading = false
            self.error = nil
        } catch {
            self.isLoading = false
            self.error = error
        }
    }
    
    @MainActor
    func getDailyForecast(for location: CLLocation) async throws {
        let dailyForecast = try await WeatherService.shared.weather(for: location).dailyForecast
        
        dailyForecast.forEach {
            dailyWeather.append(DayWeatherData(date: $0.date, symbolName: $0.symbolName, highTemperature: $0.highTemperature.value, lowTemperature: $0.lowTemperature.value))
        }
    }
    
    @MainActor
    func getHourForecast(for location: CLLocation) async throws {
        let hourForecast = try await WeatherService.shared.weather(for: location).hourlyForecast
        
        let now = Date()
        let calendar = Calendar.current
        
        // 현재 시간의 정각 시점을 계산
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        let currentHour = components.hour!
        let startOfHour = calendar.date(bySettingHour: currentHour, minute: 0, second: 0, of: now)!
        
        // 현재 시간보다 이전의 정각
        let previousHour = startOfHour <= now ? startOfHour : calendar.date(byAdding: .hour, value: -1, to: startOfHour)!
        
        let oneDayAfter = calendar.date(byAdding: .hour, value: 24, to: previousHour)!
        
        let filteredForecast = hourForecast.filter { forecast in
            return forecast.date >= previousHour && forecast.date <= oneDayAfter
        }
        
//        filteredForecast.forEach {
//            print($0)
//            print("====================================")
//        }
    }
}
