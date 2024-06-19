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
    
    private lazy var currentPlaceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("현재 위치에서 검색", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(currentButtonTapped), for: .touchUpInside)
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
        
        viewModel.$locationList
            .receive(on: RunLoop.main)
            .sink {[weak self] lists in
                self?.addPinsToMap(lists)
            }
            .store(in: &cancellables)
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
    
    //MARK: - Base UI Setup
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
    
    private func addPinsToMap(_ items: [BasedItem]) {
        for item in items {
            let coordinate = CLLocationCoordinate2D(latitude: Double(item.mapY ?? "") ?? 0.0,
                                                    longitude: Double(item.mapX ?? "") ?? 0.0)
            let annotation = CustomAnnotation(coordinate: coordinate, item: item)
            
            mapView.addAnnotation(annotation)
        }
    }
    
    //MARK: - LocationManager Setup
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    //MARK: Action Event
    @objc func listButotnTapped() {
        
        let locationList = viewModel.locationList
        //TODO: - 현재 나의 위치를 기준으로 목록리스트를 띄워줌 -> 리스트는 페이징 처리 X 현재 내위치 기준에서 있는 목록만 보여줄거임
        let listVC = PlaceListViewController(locationList: locationList)
        let vc = UINavigationController(rootViewController: listVC)
            
        
        let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
            let screenHeight = UIScreen.main.bounds.height
            //87.89%이상은 현재 viewcontroller가 뒤로 밀리면서 작아짐
            return screenHeight * 0.878912
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [customDetent] // detent 설정
            sheet.preferredCornerRadius = 30 // 둥글기 수정
            // ✅ grabber를 보이지 않게 구현.(UI를 위해 이미지로 대체)
            // sheet.prefersGrabberVisible = false // 기본값
            
            // ✅ 스크롤 상황에서 최대 detent까지 확장하는 여부 결정.
            // sheet.prefersScrollingExpandsWhenScrolledToEdge = true // 기본값
        }
        present(vc, animated: true)
    }
    
    @objc func currentButtonTapped() {
        guard let coordinator = locationManager.location?.coordinate else {
            return
        }
        setRegion(coordinate: coordinator)
    }
}


//MARK: - CLLocationManager Delegate
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
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let coordinate = view.annotation?.coordinate else { return }
        setRegion(coordinate: coordinate)
    }
    
    /// coordinate를 기준으로 Region 설정 후 해당위치로 이동시킴(가로세로 1000미터 영역으로 설정함)
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
            
            // 가장 가까운 어노테이션을 선택하여 callout 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                mapView.selectAnnotation(closestAnnotation, animated: true)
            }
        } else {
            guard let coordinate = view.annotation?.coordinate else { return }
            // 선택된 주석(annotation)이 클러스터가 아닌 경우 처리
            setRegion(coordinate: coordinate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let annotation = view.annotation {
                    mapView.selectAnnotation(annotation, animated: true)
                }
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
        if annotationView == nil {
            annotationView = CustomClusterAnnotationView(annotation: cluster, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = cluster
        }
        return annotationView
    }
    
    private func dequeueCustomAnnotationView(for annotation: CustomAnnotation, on mapView: MKMapView) -> CustomAnnotationView? {
        let identifier = "CustomAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        
        if let url = annotation.item?.imageUrl, !url.isEmpty {
            ImageLoader.loadImageFromUrl(url) { image in
                DispatchQueue.main.async {
                    let resizedImage = image?.resized(to: CGSize(width: 30, height: 30))
                    let circularImage = resizedImage?.circularImage(withBorderWidth: 2.0, borderColor: .white)
                    annotationView?.image = circularImage
                }
            }
        } else {
            annotationView?.image = UIImage(systemName: "questionmark")?.resized(to: CGSize(width: 30, height: 30))?.circularImage(withBorderWidth: 2.0, borderColor: .white)
        }
        annotationView?.clusteringIdentifier = "CustomAnnotation"
        return annotationView
    }
}


