//
//  PokemonDetailsPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 20/07/23.
//

import UIKit

protocol PokemonDetailsPresentationLogic {
    func presentScreenValues(_ pokemon: Pokemon)
}

final class PokemonDetailsPresenter: PokemonDetailsPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: PokemonDetailsDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(_ pokemon: Pokemon) {
        let types = pokemon.types.components(separatedBy: ",")
        let stats = pokemon.stats.components(separatedBy: ",")
        
        let viewModel = PokemonDetails.Model.ViewModel(id: pokemon.id, name: pokemon.name, types: types, sprite: pokemon.sprite, abilities: pokemon.abilities, height: pokemon.height, weight: pokemon.weight, stats: stats)
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
