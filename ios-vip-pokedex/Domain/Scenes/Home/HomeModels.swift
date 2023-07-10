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
        }

        struct PokemonTypes: Decodable {
            let type: Types
            
            struct Types: Decodable {
                let name: String
            }
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
                    
                    enum CodingKeys : String, CodingKey {
                        case frontDefault = "front_default"
                    }
                }
            }
        }
    }
}
