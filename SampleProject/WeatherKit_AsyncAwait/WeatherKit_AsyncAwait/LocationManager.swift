//
//  LocationManager.swift
//  WeatherKit_AsyncAwait
//
//  Created by Chung Wussup on 6/25/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var location: CLLocation? = nil
    @Published var address: String = ""
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.startUpdateLocation()
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else { return }
        getAddress(for: latestLocation)
        self.location = latestLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func getAddress(for location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if error != nil {
                return
            }
            if let placemark = placemarks?.first {
                
                if let locality = placemark.locality {
                    self?.address = "\(locality)"
                }
                
                self?.locationManager.stopUpdatingLocation()
            }
        }
    }
    
    func startUpdateLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func stopUpdateLocation() {
        self.locationManager.stopUpdatingLocation()
    }
}
