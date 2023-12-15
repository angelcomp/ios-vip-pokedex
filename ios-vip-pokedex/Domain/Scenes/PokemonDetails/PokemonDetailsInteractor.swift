//
//  PokemonDetailsInteractor.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 20/07/23.
//

import UIKit

protocol PokemonDetailsBusinessLogic {
    func loadScreenValues()
}

protocol PokemonDetailsDataStore {
     var pokemon: Pokemon? { get set }
}

final class PokemonDetailsInteractor: PokemonDetailsBusinessLogic, PokemonDetailsDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: PokemonDetailsPresentationLogic?
    let worker: PokemonDetailsWorkerLogic
    
    // MARK: - DataStore Objects
    
    var pokemon: Pokemon?
    
    // MARK: - Interactor Lifecycle
    
    init(worker: PokemonDetailsWorkerLogic = PokemonDetailsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        guard let pokemon = pokemon else { return }
        presenter?.presentScreenValues(pokemon)
    }
}
