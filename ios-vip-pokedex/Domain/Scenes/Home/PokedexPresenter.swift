//
//  PokedexPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol PokedexPresentationLogic {
    func presentScreenValues(_ response: [Pokemon], _ increasingSort: Bool)
    func presentScreenError(_ error: Error)
}

final class PokedexPresenter: PokedexPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: PokedexDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(_ response: [Pokemon], _ increasingSort: Bool) {
        var sorted = response.sorted {
            $0.id < $1.id
        }
        
        if increasingSort == false {
            sorted = sorted.reversed()
        }
        
        let viewModel = Pokedex.Model.PokemonViewModel(pokemons: sorted)
        viewController?.displayScreenValues(viewModel)
    }
    
    func presentScreenError(_ error: Error) {
        viewController?.presentScreenError()
    }
}
