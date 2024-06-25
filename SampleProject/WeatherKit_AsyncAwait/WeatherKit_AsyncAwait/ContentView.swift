//
//  ContentView.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                VStack {
                    if let _ = locationManager.location {
                        if let weatherData = viewModel.weather {
                            Text("나의 위치")
                                .font(.system(size: 20))
                            
                            Text("\(locationManager.address)")
                            
                            Text("\(String(format: "%.2f", weatherData.temperature))°")
                                .font(.system(size: 35))
                            
                            Text("\(weatherData.description)")
                            Text("습도: \(String(format: "%.2f", weatherData.humidity))%")
                            Text("풍속: \(String(format: "%.2f", weatherData.windSpeed))m/s")
                        } else if viewModel.isLoading {
                            Text("날씨 정보를 가져오는 중...")
                        } else if let error = viewModel.error {
                            Text("에러: \(error.localizedDescription)")
                        }
                    } else {
                        Text("위치 정보를 가져오는 중...")
                    }
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundStyle(.blue)
                        Text("10일간의 일기예보")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    }
                    .padding(.leading)
                    
                    ForEach(viewModel.dailyWeather, id: \.date) { dailyWeather in
                        WeatherDailyRow(weatherData: DayWeatherData(date: dailyWeather.date,
                                                                    symbolName: dailyWeather.symbolName,
                                                                    highTemperature: dailyWeather.highTemperature,
                                                                    lowTemperature: dailyWeather.lowTemperature))
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            .onChange(of: locationManager.location, { _, newValue in
                if let location = newValue {
                    Task {
                        do {
                            try await viewModel.fetchWeathers(for: location)
                        } catch {
                            print("Failed to fetch weather: \(error.localizedDescription)")
                        }
                    }
                }
            })
        }
    }
    
    func refreshWeather() {
        self.locationManager.startUpdateLocation()
        
        guard let location = locationManager.location else {
            locationManager.stopUpdateLocation()
            return
        }
        
        Task {
            do {
                try await viewModel.fetchWeathers(for: location)
            } catch {
                print("Failed to fetch weather: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
