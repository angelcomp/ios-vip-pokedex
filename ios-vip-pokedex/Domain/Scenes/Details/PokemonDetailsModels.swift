//
//  PokemonDetailsModels.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 20/07/23.
//

import UIKit

enum PokemonDetails {
    enum Model {
        struct Request {}
        struct Response {}
        struct ViewModel {
            var id: String
            var name: String
            var types: [String]
            var sprite: String
            var abilities: [String]
            let height: Int
            let weight: Int
            var stats: [String: Int]
        }
    }
}
