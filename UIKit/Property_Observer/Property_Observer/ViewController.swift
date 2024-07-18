//
//  ViewController.swift
//  Property_Observer
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var randomTitle: [String] = ["FCSeoul", "Buchen", "Seoul","Random", "swift", "swiftui", "python", "java"]
    
    var titleText: String = "" {
        willSet {
            print("newValue: " , newValue)
        }
        didSet {
            print("oldValue: ", oldValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
    }
    
    @IBAction func touchButton(_ sender: Any) {
        titleText = self.randomTitle.randomElement() ?? ""
        DispatchQueue.main.async {
            self.titleLabel.text = self.titleText
        }
        
    }
    


}
