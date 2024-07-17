//
//  CandyViewInteractor.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation
import UIKit


protocol CandyViewInteractorInput: AnyObject {
    func fetchData()
}

protocol CandyViewInteractorOutput: AnyObject {
    func fetchCandy(candy: CandyEntity)
}

class CandyViewInteractor {
    weak var output: CandyViewInteractorOutput!
}

extension CandyViewInteractor: CandyViewInteractorInput {
    func fetchData() {
        let candy = CandyEntity(title: "캐캐캐캐캔디", description: "스크린을 가득 채우는 상상 속 디저트를 바라보니 어느새 달콤한 맛이 그리워지기도 했는데요. 영화 <웡카>는 꼭 초콜릿과 함께 음미하세요.", price: 2500.0, imageName: "https://picsum.photos/300")
        self.output.fetchCandy(candy: candy)
    }
    
}




extension UIImageView {
    func imageLoad(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

