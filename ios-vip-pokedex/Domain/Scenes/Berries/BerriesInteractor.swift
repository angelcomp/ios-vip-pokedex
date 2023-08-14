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
     var berry: Berry? { get set }
}

final class BerriesInteractor: BerriesBusinessLogic, BerriesDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: BerriesPresentationLogic?
    let worker: BerriesWorkerLogic
    
    // MARK: - DataStore Objects
    
     var berry: Berry?
    
    // MARK: - Interactor Lifecycle
    
    init(worker: BerriesWorkerLogic = BerriesWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        let group = DispatchGroup()
        var berriesList: [Berry] = []
        
        for i in 1...64 {
            group.enter()
            worker.fetchBerry("\(i)") { response in
                berriesList.append(response)
                group.leave()
            } fail: {
                self.presenter?.presentScreenError()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.presenter?.presentScreenValues(berriesList)
        }
    }
}
