//
//  Router.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import Foundation
import UIKit

protocol PokeListWireFrameInput {
    func presentDetailInterfaceForPoke(poke: PokeResults)
}

class PokeListWireframe: NSObject, PokeListWireFrameInput {
    
    //View
    weak var pokeListView: PokeListView!
    
    //다음 라우터 모듈
    
    static func start() -> UIViewController{
        let view = PokeListView()
        let presenter = PokeListPresenter()
        let interactor = PokeListInteractor()
        let router = PokeListWireframe()
        
        view.presenter = presenter
        
        interactor.output = presenter
        
        presenter.view = view
        presenter.wireframe = router
        presenter.interface = interactor
        
        router.pokeListView = view
        
        return view
    }
    
    
    
    func presentDetailInterfaceForPoke(poke: PokeResults) {
    
    }
    
    
}
