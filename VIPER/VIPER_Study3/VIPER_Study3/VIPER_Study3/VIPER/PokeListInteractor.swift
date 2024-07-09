//
//  Interactor.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import Foundation


protocol PokeListInteractorInput: AnyObject {
    func fetchPokeList()
}

class PokeListInteractor {
    let url = "https://pokeapi.co/api/v2/ability"
    
    weak var output: PokeListInteractorOutPut!
    
}

extension PokeListInteractor: PokeListInteractorInput {
    
    func fetchPokeList() {
        if let url = URL(string: self.url) {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    print("URL Session Error:", error.localizedDescription)
                    return
                }
                 
                guard let data = data else {
                    print("No have Data")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    
                    DispatchQueue.main.async {
                                 print("Pokemon Decoded: \(pokemon.results)")
                                 self.output?.pokemonFetched(pokemon: pokemon)
                             }
                    
                } catch {
                    print("Decoder Error")
                    return
                }
            }
            .resume()
        }
    }
    
}
