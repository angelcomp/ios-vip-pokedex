//
//  HomeInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues()
}

protocol HomeDataStore {
    // var name: String { get set }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: HomePresentationLogic?
    let worker: HomeWorkerLogic
    
    // MARK: - DataStore Objects
    
    // var name: String = ""
    
    // MARK: - Interactor Lifecycle
    
    init(worker: HomeWorkerLogic = HomeWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        presenter?.presentScreenValues()
    }
}
