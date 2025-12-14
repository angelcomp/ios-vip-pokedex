//
//  BerriesRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

@objc protocol BerriesRoutingLogic {
    func routeToDetails()
}

protocol BerriesDataPassing {
    var dataStore: BerriesDataStore? { get set }
}

final class BerriesRouter: NSObject, BerriesRoutingLogic, BerriesDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerriesViewController?
    var dataStore: BerriesDataStore?
    
    // MARK: - Routing Logic
    
    func routeToDetails() {
        let nextViewController = BerryDetailsViewController()
        let destinationDS = nextViewController.router?.dataStore
        if let dataStore = dataStore,
            var destinationDS = destinationDS {
            passDataToDetails(source: dataStore, destination: &destinationDS)
            viewController?.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    // MARK: - Passing data
    
    func passDataToDetails(source: BerriesDataStore, destination: inout BerryDetailsDataStore) {
        destination.berry = source.berry
    }
}
