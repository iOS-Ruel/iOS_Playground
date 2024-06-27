//
//  WeatherContentView.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/26/24.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct WeatherContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            let topEdge = proxy.safeAreaInsets.top
            
            Home(weather: $viewModel.weather,
                 adress: locationManager.address,
                 topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
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

#Preview {
    WeatherContentView()
}
