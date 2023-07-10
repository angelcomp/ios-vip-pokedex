//
//  HomePresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomePresentationLogic {
    func presentScreenValues(_ response: [Pokemon])
    func presentScreenError(_ error: Error)
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(_ response: [Pokemon]) {
        let sorted = response.sorted {
            $0.id < $1.id
        }
        let viewModel = Home.Model.PokemonViewModel(pokemons: sorted)
        viewController?.displayScreenValues(viewModel)
    }
    
    func presentScreenError(_ error: Error) {
        viewController?.presentScreenError()
    }
}
