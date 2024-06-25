//
//  WeatherDailyRow.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//

import SwiftUI

struct WeatherDailyRow: View {
    var weatherData: DayWeatherData
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 5)
            Text(displayDate(date: weatherData.date))
                .frame(alignment: .center)
            Spacer()
            Image(systemName: "\(weatherData.symbolName).fill")
                .renderingMode(.original)
                .frame(width: 40, height: 40, alignment: .center)
            Spacer()
            Text("\(String(format: "%.0f", weatherData.lowTemperature))°")
                .frame( alignment: .center)
                .foregroundStyle(.blue)
                
            Spacer()
                .frame(width: 10)
            CustomProgressBar(lowTemp: weatherData.lowTemperature, highTemp: weatherData.highTemperature)
                          .frame(width: 80, height: 5)
                .frame(width: 80, height: 5)
            Spacer()
                .frame(width: 10)
            Text("\(String(format: "%.0f", weatherData.highTemperature))°")
                .frame(alignment: .center)
            Spacer()
                .frame(width: 5)
        }
        .frame(height: 50)
    }
    
    func displayDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dateToCompare = calendar.startOfDay(for: date)
        
        if today == dateToCompare {
            return "오늘"
        } else {
            let weekdayFormatter = DateFormatter()
            weekdayFormatter.locale = Locale(identifier: "ko_KR")
            weekdayFormatter.dateFormat = "EE"
            return weekdayFormatter.string(from: date)
        }
    }
}

struct CustomProgressBar: View {
    var lowTemp: Double
    var highTemp: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
            
            GeometryReader { geometry in
                let progressWidth = CGFloat((highTemp - lowTemp) / 20.0) * geometry.size.width
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.blue, .yellow, .orange]),
                            startPoint: .leading,
                            endPoint: .trailing)
                        )
                        .frame(width: progressWidth)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
    }
}

#Preview {
    WeatherDailyRow(weatherData: DayWeatherData(date: Date(), symbolName: "cloud.sun", highTemperature: 25.72, lowTemperature: 17.74))
}
