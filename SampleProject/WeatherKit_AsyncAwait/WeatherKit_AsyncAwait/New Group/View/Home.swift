//
//  Home.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/26/24.
//

import SwiftUI

struct Home: View {
    
    @State var offset: CGFloat = 0
    @Binding var weather: WeatherData?
    
    var adress: String = "" {
        willSet {
            print("adress", adress)
        }
    }
    
    
    var topEdge: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Image("sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            .overlay(.ultraThinMaterial)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(alignment: .center, spacing: 5) {
                        if let weather = weather {
                            Text("나의 위치")
                                .font(.system(size: 35))
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                            
                            Text(adress)
                                .font(.system(size: 15))
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                            
                            
                            Text("\(String(format: "%.2f", weather.temperature))°")
                                .font(.system(size: 45))
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .opacity(getTitleOpacity())
                            
                            Text(weather.description)
                                .foregroundStyle(.secondary)
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .opacity(getTitleOpacity())
                            
                            Text("최고: \(String(format: "%.2f", weather.temperature))° 최저: \(String(format: "%.2f", weather.temperature))°")
                                .foregroundStyle(.primary)
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .opacity(getTitleOpacity())
                        } else {
                            Text("데이터 불러오는 중")
                                .font(.system(size: 35))
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                            
                        }
                        
                    }
                    .offset(y: -offset)
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    VStack(spacing: 8) {
                        
                        
                        CustomStackView {
                            Label {
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                        } contentView: {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.min")
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.min")
                                    ForecastView(time: "12 PM",celcius: 94, image: "cloud")
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.min")
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.min")
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.haze")
                                    ForecastView(time: "12 PM",celcius: 94, image: "sun.min")
                                }
                            }
                        }
                        
                        WeatherDataView()
                    }
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                .overlay(
                    GeometryReader {proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                            
                        }
                        return Color.clear
                        
                    }
                )
            }
        }
    }
    
    func getTitleOpacity() -> CGFloat {
        let titleOffset = -getTitleOffset()
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    
    
    func getTitleOffset() -> CGFloat {
        if offset < 0 {
            let progress = -offset / 120
            let newOffset = (progress <= 1.0 ? progress : 1) * 30
            print(newOffset)
            return -newOffset
            
        }
        
        return 0
        
    }
}

#Preview {
    WeatherContentView()
}

struct ForecastView: View {
    
    var time: String
    var celcius: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName:image)
            //                                            .renderingMode(.original)
                .font(.title2)
                .symbolVariant(.fill)
                .symbolRenderingMode(.multicolor)
                .foregroundStyle(.yellow, .white)
                .frame(height: 30)
            
            
            Text("\(Int(celcius))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
