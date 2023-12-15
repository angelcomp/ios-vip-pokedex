//
//  BerryDetailsInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

protocol BerryDetailsBusinessLogic {
    func loadScreenValues()
}

protocol BerryDetailsDataStore {
    // var name: String { get set }
}

final class BerryDetailsInteractor: BerryDetailsBusinessLogic, BerryDetailsDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: BerryDetailsPresentationLogic?
    let worker: BerryDetailsWorkerLogic
    
    // MARK: - DataStore Objects
    
    // var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: BerryDetailsWorkerLogic = BerryDetailsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
