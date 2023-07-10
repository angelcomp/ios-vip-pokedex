//
//  HomeInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues(listAmount: Int)
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

    
    func loadScreenValues(listAmount: Int) {
        let group = DispatchGroup()
        var pokemonList: [Pokemon] = []
        
        for i in 1...listAmount {
            group.enter()
            worker.fetchPokemon("\(i)") { response in
                pokemonList.append(response)
                group.leave()
                
            } fail: { error in
                self.presenter?.presentScreenError(error)
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.presenter?.presentScreenValues(pokemonList)
        }
    }
}
