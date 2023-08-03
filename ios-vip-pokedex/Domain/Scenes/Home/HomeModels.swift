//
//  HomeModels.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

typealias Pokemon = Home.Model.PokemonResponse

enum Home {
    enum Model {
        struct PokemonRequest {}
        struct PokemonViewModel {
            var pokemons: [Pokemon]
        }
        
        struct PokemonResponse: Decodable {
            let id: Int
            let name: String
            let types: [PokemonTypes]
            let sprites: Sprites
            let abilities: [Abilities]
            let stats: [Stats]
            let height: Int
            let weight: Int
        }

        struct PokemonTypes: Decodable {
            let type: Types
        }
        
        struct Stats: Decodable {
            let baseStat: Int
            let stat: Types
            
            enum CodingKeys: String, CodingKey {
                case baseStat = "base_stat"
                case stat
            }
        }
        
        struct Abilities: Decodable {
            let ability: Types
        }
        
        struct Types: Decodable {
            let name: String
        }

        struct Sprites: Decodable {
            let other: Other
            
            struct Other: Decodable {
                let officialArtwork: OfficialArtwork
                
                enum CodingKeys : String, CodingKey {
                    case officialArtwork = "official-artwork"
                }
                
                struct OfficialArtwork: Decodable {
                    let frontDefault: String?
                    
                    enum CodingKeys: String, CodingKey {
                        case frontDefault = "front_default"
                    }
                }
            }
        }
    }
}
