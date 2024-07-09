//
//  PokeListPresenter.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import Foundation


protocol PokeListInteractorOutPut: AnyObject {
    func pokemonFetched(pokemon: Pokemon)
}


protocol PokeListModuleInterface: AnyObject {
    func updateView()
    func showDetailForPoke(poke: PokeResults)
}



class PokeListPresenter: PokeListModuleInterface, PokeListInteractorOutPut {
    weak var view: PokeListViewInterface!
    
    var interface: PokeListInteractorInput!
    
    var wireframe: PokeListWireframe!
    
    func updateView() {
        self.interface.fetchPokeList()
    }
    
    func showDetailForPoke(poke: PokeResults) {
        //현재 다음 화면이 없기때문에 일단 생략
    }
    
    func pokemonFetched(pokemon: Pokemon) {
        if pokemon.results.count > 0 {
            self.view.showPokeData(poke: pokemon)
        } else {
            //데이터가 없을때에 대한 Method는 구현하지 않음
        }
    }
    
    
}
