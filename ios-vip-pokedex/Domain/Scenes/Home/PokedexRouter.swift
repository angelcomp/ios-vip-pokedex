//
//  PokedexRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

@objc protocol PokedexRoutingLogic {
    func routeToDetails()
}

protocol PokedexDataPassing {
    var dataStore: PokedexDataStore? { get set }
}

final class PokedexRouter: NSObject, PokedexRoutingLogic, PokedexDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: PokedexViewController?
    var dataStore: PokedexDataStore?
    
    // MARK: - Routing Logic
    
    func routeToDetails() {
        let vc = PokemonDetailsViewController()
        let destinationDS = vc.router?.dataStore
        
        if let dataStore = dataStore,
           var destinationDS = destinationDS {
            passDataToSomewhere(source: dataStore, destination: &destinationDS)
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Passing data
    
    func passDataToSomewhere(source: PokedexDataStore, destination: inout PokemonDetailsDataStore) {
        destination.pokemon = source.pokemon
    }
}
