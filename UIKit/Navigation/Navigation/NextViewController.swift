//
//  NextViewController.swift
//  Navigation
//
//  Created by Chung Wussup on 5/23/24.
//

import UIKit

protocol NextViewControllerDelegate {
    func sendAnimal(animal: Animal)
}

class NextViewController: UIViewController {
    
    var delegate: NextViewControllerDelegate?
    
    func sendAnimalData(animal: Animal) {
        self.label.text = animal.name
    }
    let label = UILabel()
    let animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "다음 화면"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = animal.name
        label.textColor = .black
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let button = UIButton(type: .system)
        button.setTitle("동물 전달", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        ])
        
        button.addAction(UIAction{ [weak self] _ in
            self?.delegate?.sendAnimal(animal: Animal(name: "호랑이"))
            self?.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        
    }
    
    
}
