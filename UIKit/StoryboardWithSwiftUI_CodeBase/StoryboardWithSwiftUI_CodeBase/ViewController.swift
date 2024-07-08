//
//  ViewController.swift
//  StoryboardWithSwiftUI_CodeBase
//
//  Created by Chung Wussup on 7/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    
    private lazy var button: UIButton = {
       let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "Button"
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        button.addAction(UIAction {[weak self] action in
            let hostingController = UIHostingController( rootView: SwiftUIView(name: "Ruel"))
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }, for:  .touchUpInside)
        
        
    }


}

