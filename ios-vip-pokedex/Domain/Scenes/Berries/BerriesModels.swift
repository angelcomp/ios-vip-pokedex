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
            let firmness: String
            let flavors: String
            let giftType: String
            let giftPower: Int
            let size: Int
            let smoothness: Int
            let soilDryness: Int
        }
        struct ViewModel {
            var berries: [Berry]
            
        }
    }
}
