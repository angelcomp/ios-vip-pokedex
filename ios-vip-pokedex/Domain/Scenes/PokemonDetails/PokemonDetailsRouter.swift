//
//  PokemonDetailsRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 20/07/23.
//

import UIKit

@objc protocol PokemonDetailsRoutingLogic {
    func routeToSomewhere()
}

protocol PokemonDetailsDataPassing {
    var dataStore: PokemonDetailsDataStore? { get }
}

final class PokemonDetailsRouter: NSObject, PokemonDetailsRoutingLogic, PokemonDetailsDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: PokemonDetailsViewController?
    var dataStore: PokemonDetailsDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: PokemonDetailsDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
