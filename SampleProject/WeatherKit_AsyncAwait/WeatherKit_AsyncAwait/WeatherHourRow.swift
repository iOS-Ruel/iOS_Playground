//
//  WeatherHourRow.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//

import SwiftUI

struct WeatherHourRow: View {
    var body: some View {
        VStack {
            Text("지금")
            Image(systemName: "sun.max")
                .frame(width: 45, height: 45)
            Text("25")
        }
//        .frame(width: 60, height: 80)
    }
}

#Preview {
    WeatherHourRow()
}


//HourWeather(date: 2024-06-26 06:00:00 +0000, cloudCover: 0.11, cloudCoverLow: 0.0, cloudCoverMid: 0.0, cloudCoverHigh: 0.0, condition: Clear, symbolName: "sun.max", dewPoint: 17.05 °C, humidity: 0.5, isDaylight: true, precipitation: , precipitationChance: 0.0, precipitationAmount: 0.0 mm, snowfallAmount: 0.0 mm, pressure: 1014.41 mbar, pressureTrend: Falling, temperature: 28.48 °C, apparentTemperature: 29.35 °C, uvIndex: WeatherKit.UVIndex(value: 6, category: High), visibility: 23516.0 m, wind: WeatherKit.Wind(compassDirection: West, direction: 269.0 °, speed: 14.33 km/h, gust: Optional(24.35 km/h)))
