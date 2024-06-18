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

    }
    
    @objc func listButotnTapped() {
//        let listVC = PlaceListViewController()
//        
//        
//        // ✅ custom detent 생성
//        let detentIdentifier = UISheetPresentationController.Detent.Identifier("customDetent")
//        let customDetent = UISheetPresentationController.Detent.custom(identifier: detentIdentifier) { _ in
//
//            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//            let safeAreaBottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
//
//            return 780 - safeAreaBottom
//        }
//
//        if let sheet = listVC.sheetPresentationController {
//            sheet.detents = [customDetent] // detent 설정
//            sheet.preferredCornerRadius = 30 // 둥글기 수정
//
//            // ✅ grabber를 보이지 않게 구현.(UI를 위해 이미지로 대체)
//            // sheet.prefersGrabberVisible = false // 기본값
//
//            // ✅ 스크롤 상황에서 최대 detent까지 확장하는 여부 결정.
//            // sheet.prefersScrollingExpandsWhenScrolledToEdge = true // 기본값
//        }
//
//        // ✅ 기본값 automatic. 대부분의 뷰 컨트롤러의 경우 pageSheet 스타일에 매핑.
//        // sheetVC.modalPresentationStyle = .pageSheet
//        
//        present(listVC, animated: true)
    }
    
}

