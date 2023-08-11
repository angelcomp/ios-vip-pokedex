//
//  BerriesInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesBusinessLogic {
    func loadScreenValues()
}

protocol BerriesDataStore {
    // var name: String { get set }
}

final class BerriesInteractor: BerriesBusinessLogic, BerriesDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: BerriesPresentationLogic?
    let worker: BerriesWorkerLogic
    
    // MARK: - DataStore Objects
    
    // var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: BerriesWorkerLogic = BerriesWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
