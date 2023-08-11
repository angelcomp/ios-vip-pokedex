//
//  PokedexInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol PokedexBusinessLogic {
    func loadScreenValues(_ offset: Int, _ limit: Int, _ increasingSort: Bool)
}

protocol PokedexDataStore {
     var pokemon: Pokemon? { get set }
}

final class PokedexInteractor: PokedexBusinessLogic, PokedexDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: PokedexPresentationLogic?
    let worker: PokedexWorkerLogic
    
    // MARK: - DataStore Objects
    
    var pokemon: Pokemon?
    
    // MARK: - Interactor Lifecycle
    
    init(worker: PokedexWorkerLogic = PokedexWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues(_ offset: Int, _ limit: Int, _ increasingSort: Bool) {
        let group = DispatchGroup()
        var pokemonList: [Pokemon] = []
        
        for i in offset - limit + 1...offset {
            if i <= 1000 {
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
