//
//  BerriesModels.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

typealias Berry = Berries.Model.Response

enum Berries {
    enum Model {
        struct Request {}
        struct Response: Decodable {
            let id: Int
            let name: String
            var firmness: Name
            let flavors: [Flavor]
            let size, smoothness, soilDryness: Int

            enum CodingKeys: String, CodingKey {
                case firmness, flavors
                case id
                case name
                case size, smoothness
                case soilDryness = "soil_dryness"
            }
        }

        struct Name: Decodable {
            var name: String
        }

        struct Flavor: Decodable {
            let flavor: Name
            let potency: Int
        }
        
        struct ViewModel {
            var berries: [Berry]
        }
    }
}
