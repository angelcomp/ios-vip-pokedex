//
//  BerryDetailsRouter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

@objc protocol BerryDetailsRoutingLogic {
    func routeToSomewhere()
}

protocol BerryDetailsDataPassing {
    var dataStore: BerryDetailsDataStore? { get }
}

final class BerryDetailsRouter: NSObject, BerryDetailsRoutingLogic, BerryDetailsDataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerryDetailsViewController?
    var dataStore: BerryDetailsDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSomewhere() {
        //let nextController = NextViewController()
        //var destinationDS = nextController.router?.dataStore
        //passDataToSomewhere(source: dataStore, destination: &destinationDS)
        //viewController?.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    // MARK: - Passing data
    
    //func passDataToSomewhere(source: BerryDetailsDataStore, destination: inout SomewhereDataStore) {
        //destination.name = source.name
    //}
}
