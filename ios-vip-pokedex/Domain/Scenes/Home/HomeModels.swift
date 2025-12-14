//
//  PokedexModels.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

typealias Pokemon = Pokedex.Model.PokemonResponse

enum Pokedex {
    enum Model {
        struct PokemonRequest {}
        struct PokemonViewModel {
            var pokemons: [Pokemon]
        }
        
        struct PokemonResponse: Decodable {
            let id: Int
            let name: String
            let types: String
            let sprite: String
            let abilities: String
            let stats: String
            let height: Int
            let weight: Int
            //            let items: Stats
        }
    }
}
