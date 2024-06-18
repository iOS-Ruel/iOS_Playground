//
//  CustomAnnotation.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/17/24.
//

import MapKit
import UIKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var item: BasedItem?
    var title: String?
    var subtitle: String?
    
    
    init(coordinate: CLLocationCoordinate2D, item: BasedItem) {
        self.coordinate = coordinate
        self.item = item
        self.title = item.title
        self.subtitle = item.subTitle
    }
}


class CustomAnnotationView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? CustomAnnotation else { return }
            clusteringIdentifier = "CustomAnnotation"
            canShowCallout = true
            setupMarkerAppearance(for: customAnnotation)
            setupCallout(for: customAnnotation)
        }
    }
    
    private func setupMarkerAppearance(for annotation: CustomAnnotation) {
        self.glyphImage = nil
        self.glyphTintColor = .clear
        self.glyphText = ""
        self.markerTintColor = .clear
        
        if let url = annotation.item?.imageUrl, !url.isEmpty {
            ImageLoader.loadImageFromUrl(url) { image in
                
                DispatchQueue.main.async {
                    let resizedImage = image?.resized(to: CGSize(width: 30, height: 30))
                    let circularImage = resizedImage?.circularImage(withBorderWidth: 2.0, borderColor: .white)
                    self.image = circularImage
                }
                
            }
            
        } else {
            self.image = UIImage(systemName: "questionmark")?.resized(to: CGSize(width: 30, height: 30))?.circularImage(withBorderWidth: 2.0, borderColor: .white)
        }
    }
    
    private func setupCallout(for annotation: CustomAnnotation) {
            // Callout의 왼쪽 뷰 설정 (예: 이미지)
            let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            leftIconView.contentMode = .scaleAspectFill
            leftIconView.layer.cornerRadius = 15
            leftIconView.clipsToBounds = true
            
            if let url = annotation.item?.imageUrl, !url.isEmpty {
                ImageLoader.loadImageFromUrl(url) { image in
                    DispatchQueue.main.async {
                        leftIconView.image = image
                    }
                }
            } else {
                leftIconView.image = UIImage(systemName: "questionmark")
            }
            self.leftCalloutAccessoryView = leftIconView
            
            // Callout의 오른쪽 뷰 설정 (예: 상세 정보 버튼)
            let rightButton = UIButton(type: .detailDisclosure)
            self.rightCalloutAccessoryView = rightButton
            
            // Callout의 세부 정보 뷰 설정 (예: 사용자 정의 뷰)
            let detailView = UIView()
//            let titleLabel = UILabel()
//            titleLabel.text = annotation.title
//            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            
            let subtitleLabel = UILabel()
            subtitleLabel.text = annotation.subtitle
            subtitleLabel.font = UIFont.systemFont(ofSize: 12)
            
//            detailView.addSubview(titleLabel)
            detailView.addSubview(subtitleLabel)
            
//            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
//                titleLabel.topAnchor.constraint(equalTo: detailView.topAnchor),
//                titleLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
//                titleLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
                subtitleLabel.topAnchor.constraint(equalTo: detailView.topAnchor),
                subtitleLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
                subtitleLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
                subtitleLabel.bottomAnchor.constraint(equalTo: detailView.bottomAnchor)
            ])
            
            self.detailCalloutAccessoryView = detailView
        }
}

class CustomClusterAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let cluster = newValue as? MKClusterAnnotation else { return }
            updateClusterAppearance(for: cluster)
        }
    }
    
    private func updateClusterAppearance(for cluster: MKClusterAnnotation) {
        var annotationImage: UIImage? = nil
        self.displayPriority = .required
        
        for member in cluster.memberAnnotations {
            if let customAnnotation = member as? CustomAnnotation, let url = customAnnotation.item?.imageUrl, !url.isEmpty {
                ImageLoader.loadImageFromUrl(url) { image in
                    annotationImage = image
                }
                break
            }
        }
        
        DispatchQueue.main.async {
            if let image = annotationImage {
                self.image = image.resized(to: CGSize(width: 30, height: 30))?.circularImage(withBorderWidth: 2.0, borderColor: .white)
            } else {
                self.image = UIImage(systemName: "questionmark")?.resized(to: CGSize(width: 30, height: 30))?.circularImage(withBorderWidth: 2.0, borderColor: .white)
            }
        }
    }
}


