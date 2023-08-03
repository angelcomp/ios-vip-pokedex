//
//  HomeRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToDetails()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get set }
}

final class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
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
    
    func passDataToSomewhere(source: HomeDataStore, destination: inout PokemonDetailsDataStore) {
        destination.pokemon = source.pokemon
    }
}
