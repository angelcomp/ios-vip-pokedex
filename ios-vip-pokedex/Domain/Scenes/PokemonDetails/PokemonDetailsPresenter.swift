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
        let id = String(pokemon.id)
        let name = pokemon.name.capitalized
        let height = pokemon.height
        let weight = pokemon.weight
        let sprite = pokemon.sprites.other.officialArtwork.frontDefault ?? ""
        
        var stats = pokemon.stats.reduce(into: [String: Int]()) {
            $0[$1.stat.name.capitalized] = $1.baseStat
        }
        
        let abilities = pokemon.abilities.map { item in
            item.ability.name
        }
        
        let types = pokemon.types.map { item in
            item.type.name
        }
        
        let viewModel = PokemonDetails.Model.ViewModel(id: id, name: name, types: types, sprite: sprite, abilities: abilities, height: height, weight: weight, stats: stats)
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
