//
//  ViewController.swift
//  Gesture
//
//  Created by Chung Wussup on 5/22/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rectangle = UIView()
        rectangle.backgroundColor = .yellow
        rectangle.frame = CGRect(x: 100, y: 100, width: 175, height: 125)
        rectangle.isUserInteractionEnabled = true
        
        
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
//        imageView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        imageView.frame = CGRect(x: view.bounds.midX - 100 , y: view.bounds.midY - 100, width: 200, height: 200)
        imageView.isUserInteractionEnabled = true
        
        view.addSubview(imageView)
        view.addSubview(rectangle)
        
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture))
        //        gesture.numberOfTapsRequired = 2
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture))
        gesture.minimumPressDuration = 2.0
        rectangle.addGestureRecognizer(gesture)
        
        
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchHandleGesture))
//        imageView.addGestureRecognizer(pinchGesture)
        let lotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGesture))
        imageView.addGestureRecognizer(lotationGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        imageView.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        imageView.addGestureRecognizer(panGesture)
        
        lotationGesture.delegate = self
        panGesture.delegate = self
        pinchGesture.delegate = self
    }
    
    //    @objc func handleGesture(_ sender: UIGestureRecognizer) {
    @objc func handleGesture(_ sender: UILongPressGestureRecognizer) {
        if let view = sender.view, sender.state == .began {
            view.backgroundColor = view.backgroundColor == .yellow ? .red : .yellow
        }
    }
    
    var lastScale: CGFloat = 1.0
    
    @objc func pinchHandleGesture(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            
            var scale = sender.scale
            scale = max(scale, 0.8 / lastScale)
            scale = min(scale, 2.0 / lastScale)
            
            view.transform = view.transform.scaledBy(x: scale, y: scale)
            lastScale *= scale
        }
    }
    
    @objc func rotationGesture(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(.zero, in: view)
        }
    }
    
    @objc func handlePinch(_ sender: UIPinchGestureRecognizer) {
        if let view = sender.view {
            
            var scale = sender.scale
            scale = max(scale, 0.8 / lastScale)
            scale = min(scale, 2.0 / lastScale)
            
            view.transform = view.transform.scaledBy(x: scale, y: scale)
            lastScale *= scale
        }
    }
}


extension ViewController: UIGestureRecognizerDelegate  {
    //단일제스처 제어
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer is UIPanGestureRecognizer {
//            return false
//        } else {
            return true
//        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
