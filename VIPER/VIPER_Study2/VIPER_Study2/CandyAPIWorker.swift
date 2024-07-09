//
//  CandyAPIWorker.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 5/24/24.
//

import Foundation

protocol CandyAPIWorkerProtocol {
    func fetchCandy(callBack:(CandyEntity) -> Void)
}

// Candy 오브젝트로 데이터를 얻기 위해 웹 서비스 호출을 하는 api worker을 만들었다.
class CandyAPIWorker : CandyAPIWorkerProtocol {

    func fetchCandy(callBack:(CandyEntity) -> Void) {
        let candyEntity = CandyEntity(title: "천국 사탕", description: "마법 사탕은 천국에서 만들어집니다. 맛보고 싶으시다면 주문하세요! \n#마약 아닙니다. #사기 아닙니다.", price: 100, imageName: "magic_candy")
        callBack(candyEntity)
    }
}
