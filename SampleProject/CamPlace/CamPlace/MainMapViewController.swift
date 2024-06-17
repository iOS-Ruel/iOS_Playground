//
//  MainMapViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import UIKit
import MapKit
import CoreLocation
import Combine


class MainMapViewController: UIViewController {
    let locationManager = CLLocationManager()
    
    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.preferredConfiguration = MKStandardMapConfiguration()
        mv.showsUserLocation = true
        return mv
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("목록 보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(listButotnTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let viewModel = MainMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    private func setup() {
        self.view.backgroundColor = .white
        setUpMapView()
        setupUI()
    }
    
    //MARK: - MapView Setup
    private func setUpMapView() {
        self.view.addSubview(mapView)
        mapView.delegate = self
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        self.view.addSubview(listButton)
        NSLayoutConstraint.activate([
            listButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listButton.heightAnchor.constraint(equalToConstant: 40),
            listButton.widthAnchor.constraint(equalToConstant: 120),
            listButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    
    
    //MARK: - LocationManager Setup
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: Action Event
    @objc func listButotnTapped() {
        let listVC = PlaceListViewController()
        listVC.modalPresentationStyle = .formSheet
//        listVC.sheetPresentationController?.detents = [.large(), .medium()]
//        listVC.sheetPresentationController?.selectedDetentIdentifier = .large
        
        self.present(listVC, animated: true)
    }
    
}


//MARK: - CLLocationManager Delegate
extension MainMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Auth: Allow")
            locationManager.startUpdatingLocation()
        case .notDetermined, .denied, .restricted:
            print("Location Auth: Denied")
        default:
            break
        }
    }
}


//MARK: - MKMapViewDelegate
extension MainMapViewController: MKMapViewDelegate {
}
