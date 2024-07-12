//
//  ViewController.swift
//  ConcurrencyTest
//
//  Created by Chung Wussup on 7/11/24.
//

import UIKit

class ViewController: UIViewController {
    let red = DispatchWorkItem {
        for _ in 1...5 {
            print("🥵🥵🥵🥵🥵")
            sleep(1)
        }
    }
    
    let yellow = DispatchWorkItem {
        for _ in 1...5 {
            print("😀😀😀😀😀")
            sleep(1)
        }
    }
    
    let blue = DispatchWorkItem {
        for _ in 1...5 {
            print("🥶🥶🥶🥶🥶")
            sleep(2)
        }
    }
    
    let green = DispatchWorkItem {
        for _ in 1...5 {
            print("🤢🤢🤢🤢🤢")
            sleep(1)
        }
    }
    
    let purple = DispatchWorkItem {
        for _ in 1...5 {
            print("😈😈😈😈😈")
            sleep(1)
        }
    }
    
    let orange = DispatchWorkItem {
        for _ in 1...5 {
            print("🎃🎃🎃🎃🎃")
            sleep(2)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // View의 배경색을 설정합니다.
        view.backgroundColor = .white
        
        //        // DispatchQueue를 사용하여 작업을 비동기적으로 실행합니다.
        //        DispatchQueue.main.async(execute: yellow)
        //        DispatchQueue.global().async(execute: blue)
        //        DispatchQueue.global().sync(execute: red)
        
        // 버튼을 생성하여 눌렀을 때 작업을 실행할 수 있도록 합니다.
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start Tasks", for: .normal)
        startButton.addTarget(self, action: #selector(startTasks), for: .touchUpInside)
        
        // 버튼의 레이아웃을 설정합니다.
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    @objc func startTasks() {
        // DispatchWorkItem들을 생성합니다.
        
        
        DispatchQueue.main.async(execute: yellow)
        DispatchQueue.global().async(execute: blue)
        DispatchQueue.global().sync(execute: red)
        
        // 4
        DispatchQueue.main.async(execute: green)
        DispatchQueue.global().sync(execute: purple)
        DispatchQueue.global().async(execute: orange)
    }
}

