//
//  CandyViewPresenter.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation


protocol CandyViewModuleInterface: AnyObject {
    func updateView()
}

class CandyViewPresenter: CandyViewModuleInterface, CandyViewInteractorOutput {
    weak var view: CandyViewController!
    var interface: CandyViewInteractorInput!
    var routerInput: CandyViewRouterInput!
    
    
    //input
    func updateView() {
        self.interface.fetchData()
    }
    
    //output
    func fetchCandy(candy: CandyEntity) {
        self.view.configureCandyData(candy: candy)
        print(#function,candy)
    }
    
    
}
