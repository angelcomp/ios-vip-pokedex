//
//  HomeInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeBusinessLogic {
    func loadScreenValues(_ offset: Int, _ limit: Int, _ increasingSort: Bool)
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
    
    func loadScreenValues(_ offset: Int, _ limit: Int, _ increasingSort: Bool) {
        let group = DispatchGroup()
        var pokemonList: [Pokemon] = []
        
        for i in offset - limit + 1...offset {
            if i <= 1271 {
                group.enter()
                worker.fetchPokemon("\(i)") { response in
                    pokemonList.append(response)
                    group.leave()
                } fail: { error in
                    self.presenter?.presentScreenError(error)
                }
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.presenter?.presentScreenValues(pokemonList, increasingSort)
        }
    }
}
