//
//  BerriesRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

@objc protocol BerriesRoutingLogic {
    func routeToSomewhere()
}

protocol BerriesDataPassing {
    var dataStore: BerriesDataStore? { get }
}

final class BerriesRouter: NSObject, BerriesRoutingLogic, BerriesDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerriesViewController?
    var dataStore: BerriesDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: BerriesDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
