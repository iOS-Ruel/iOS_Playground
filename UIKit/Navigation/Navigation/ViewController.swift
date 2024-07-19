//
//  ViewController.swift
//  Navigation
//
//  Created by Chung Wussup on 5/23/24.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationItem.title = "네비게이션 타이틀"
        self.title = "네비게이션 타이틀"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemCyan
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance

        
        
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(rightButtonTapped))
        let extraButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(extraButtonTapped))
        
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItems = [extraButton, rightButton]
        
        
        
        button.setTitle("다음화면으로", for: .normal)
        view.addSubview(button)
        button.addAction(UIAction { [weak self] _ in

        let nextVC = NextViewController(animal: Animal(name: "강아지"))
            nextVC.delegate = self
//            self?.navigationController?.pushViewController(nextVC, animated: true)
        self?.show(nextVC, sender: nil)
                
        }, for: .touchUpInside)
        
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
    }
    
    @objc func leftButtonTapped() {
        print("왼쪽 버튼")
    }
    
    @objc func rightButtonTapped() {
        print("오른쪽 버튼")
    }
    
    @objc func extraButtonTapped() {
        print("추가 버튼")
    }
    
    
}

extension ViewController: NextViewControllerDelegate {
    func sendAnimal(animal: Animal) {
        button.setTitle(animal.name, for: .normal)
    }
    
    
}
