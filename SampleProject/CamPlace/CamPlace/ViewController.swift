//
//  ViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import UIKit

class ViewController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(listButton)
        NSLayoutConstraint.activate([
            listButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        // Do any additional setup after loading the view.
    }
    @objc func listButotnTapped() {
        let listVC = PlaceListViewController()
        
        let customId = UISheetPresentationController.Detent.Identifier("large-minus-background-effect")
        let customDetent = UISheetPresentationController.Detent.custom(identifier: customId) { context in
            return context.maximumDetentValue - 0.1
        }
        listVC.largestUndimmedDetentIdentifier = .large
        listVC.sheetPresentationController?.detents = [customDetent]
//        listVC.sheetPresentationController?.selectedDetentIdentifier = .large
        
        self.present(listVC, animated: true)
    }

}
