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
    private var cancellables = Set<AnyCancellable>()
    
    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.translatesAutoresizingMaskIntoConstraints = false
        mv.preferredConfiguration = MKStandardMapConfiguration()
        mv.showsUserLocation = true
        mv.register(CustomAnnotationView.self,
                    forAnnotationViewWithReuseIdentifier: "CustomAnnotationView")
        mv.register(CustomClusterAnnotationView.self,
                    forAnnotationViewWithReuseIdentifier: "CustomClusterAnnotationView")
        return mv
    }()
    
    private lazy var listButton: UIButton = {
        let button = createButton(title: "목록 보기", image: "list.bullet", action: #selector(listButtonTapped))
        return button
    }()
    
    private lazy var currentPlaceButton: UIButton = {
        let button = createButton(title: "현재 위치에서 검색", image: nil, action: #selector(currentButtonTapped))
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    private var isFirstLocationUpdate = true
    
    private let viewModel = MainMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.backgroundColor = .white
        setUpMapView()
        setupUI()
        setupLocationManager()
        setupBindings()
    }
    
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
            listButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -30)
        ])
        
        self.view.addSubview(currentPlaceButton)
        NSLayoutConstraint.activate([
            currentPlaceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentPlaceButton.heightAnchor.constraint(equalToConstant: 40),
            currentPlaceButton.widthAnchor.constraint(equalToConstant: 120),
            currentPlaceButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func createButton(title: String, image: String?, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        if let imageName = image {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func setupBindings() {
        viewModel.$locationList
            .receive(on: DispatchQueue.main)
            .sink {[weak self] lists in
                print(lists.count)
                self?.addPinsToMap(lists)
            }
            .store(in: &cancellables)
    }
    
    private func addPinsToMap(_ items: [BasedItem]) {
        for item in items {
            guard let latitude = Double(item.mapY ?? ""),
                  let longitude = Double(item.mapX ?? "") else {
                print("Invalid coordinates")
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                    longitude: longitude)
            let annotation = CustomAnnotation(coordinate: coordinate, item: item)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @objc private func listButtonTapped() {
        let locationList = viewModel.locationList
        let listVC = PlaceListViewController(locationList: locationList)
        let vc = UINavigationController(rootViewController: listVC)
        
        let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
            let screenHeight = UIScreen.main.bounds.height
            return screenHeight * 0.878912
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [customDetent]
            sheet.preferredCornerRadius = 30
        }
        present(vc, animated: true)
    }
    
    @objc private func currentButtonTapped() {
        guard let coordinator = locationManager.location?.coordinate else {
            return
        }
        setRegion(coordinate: coordinator)
    }
}

extension MainMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        if isFirstLocationUpdate {
            viewModel.getLocationList(mapX: "\(location.coordinate.longitude)",
                                      mapY: "\(location.coordinate.latitude)",
                                      radius: "20000")
            setRegion(coordinate: location.coordinate)
            isFirstLocationUpdate = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to Fetch Location (\(error))")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined, .denied, .restricted:
            print("Location Auth: Denied")
        default:
            break
        }
    }
}

extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let title = view.annotation?.title, let placeName = title {
            if let content = viewModel.getLocationContent(title: placeName) {
                let viewModel = PlaceDetailViewModel(content: content)
                let vc = PlaceDetailViewController(viewModel: viewModel)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    private func setRegion(coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func closestAnnotation(to coordinate: CLLocationCoordinate2D, in annotations: [MKAnnotation]) -> MKAnnotation? {
        var closestAnnotation: MKAnnotation?
        var closestDistance: CLLocationDistance = CLLocationDistanceMax
        
        let targetLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        for annotation in annotations {
            let annotationLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            let distance = targetLocation.distance(from: annotationLocation)
            
            if distance < closestDistance {
                closestDistance = distance
                closestAnnotation = annotation
            }
        }
        
        return closestAnnotation
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let clusterAnnotation = view.annotation as? MKClusterAnnotation {
            guard let closestAnnotation = closestAnnotation(to: clusterAnnotation.coordinate,
                                                            in: clusterAnnotation.memberAnnotations) else { return }
            
            let closestCoordinate = closestAnnotation.coordinate
            setRegion(coordinate: closestCoordinate)
            
            
            mapView.selectAnnotation(closestAnnotation, animated: true)
            
        } else {
            guard let coordinate = view.annotation?.coordinate else { return }
            setRegion(coordinate: coordinate)
            
            if let annotation = view.annotation {
                mapView.selectAnnotation(annotation, animated: true)
            }
            
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let cluster = annotation as? MKClusterAnnotation {
            return dequeueClusterAnnotationView(for: cluster, on: mapView)
        } else if let customAnnotation = annotation as? CustomAnnotation {
            return dequeueCustomAnnotationView(for: customAnnotation, on: mapView)
        }
        return nil
    }
    
    private func dequeueClusterAnnotationView(for cluster: MKClusterAnnotation, on mapView: MKMapView) -> CustomClusterAnnotationView? {
        let identifier = "CustomClusterAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomClusterAnnotationView
        
        if (annotationView == nil) {
            annotationView = CustomClusterAnnotationView(annotation: cluster, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = cluster
        }
        return annotationView
    }
    
    private func dequeueCustomAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> CustomAnnotationView? {
        let identifier = "CustomAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
        
        if (annotationView == nil) {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if let url = annotation.item?.imageUrl, !url.isEmpty {
            ImageLoader.loadImageFromUrl(url)
                .receive(on: DispatchQueue.main)
                .sink { [weak annotationView] image in
                    let resizedImage = image?.resized(to: CGSize(width: 30, height: 30))
                    let circularImage = resizedImage?.circularImage(withBorderWidth: 2.0, borderColor: .white)
                    annotationView?.image = circularImage
                }
                .store(in: &cancellables)
        } else {
            annotationView?.image = UIImage(systemName: "questionmark")?.resized(to: CGSize(width: 30, height: 30))?.circularImage(withBorderWidth: 2.0, borderColor: .white)
        }
        annotationView?.clusteringIdentifier = "CustomAnnotation"
        return annotationView
    }
}
