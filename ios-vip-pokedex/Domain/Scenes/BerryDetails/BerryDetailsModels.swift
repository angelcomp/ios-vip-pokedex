//
//  BerryDetailsModels.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

enum BerryDetails {
    enum Model {
        struct ViewModel {
            var id: Int
            var name: String
            var firmness: String
            var flavors: String
            var size, smoothness, soilDryness: Int
            var imageData: Data?
        }
    }
}
