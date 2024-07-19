//
//  ViewController.swift
//  StackView
//
//  Created by Chung Wussup on 5/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        label.text = "값: 0"
        
        slider.maximumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.isContinuous = true
        
        slider.addAction(
            UIAction{ [weak self] _ in
                self?.label.text = "값: \(String(format:"%.1f", self?.slider.value ?? 0))"
            }, for: .valueChanged)
        
         
        let stackView = UIStackView(arrangedSubviews: [label, slider])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}

