//
//  ViewController.swift
//  Picker
//
//  Created by Chung Wussup on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let button = UIButton()
        var configure = UIButton.Configuration.filled()
        configure.title = "Color Pikcer"
        configure.cornerStyle = .capsule
        
        button.configuration = configure
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            UIAction { [weak self] _ in
                let colorPicker = UIColorPickerViewController()
                colorPicker.delegate = self
                colorPicker.supportsAlpha = false
                colorPicker.selectedColor = self?.view.backgroundColor ?? .white
                self?.present(colorPicker, animated: true)
                
            }, for: .touchUpInside)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
    }
    
}

extension ViewController: UIColorPickerViewControllerDelegate {
    
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.view.backgroundColor = viewController.selectedColor
        
    }
}
