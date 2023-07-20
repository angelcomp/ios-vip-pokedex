//
//  HomeWorker.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeWorkerLogic {
    var apiManager: ApiManager { get }
    func fetchPokemon(_ id: String, success: @escaping(Pokemon) -> Void, fail: @escaping(Error) -> Void)
}

final class HomeWorker: HomeWorkerLogic {
    
    var apiManager: ApiManager = ApiManager()
    
    func fetchPokemon(_ id: String, success: @escaping(Pokemon) -> Void, fail: @escaping(Error) -> Void) {
        apiManager.getPokemons(endpoint: "/pokemon/\(id)", params: nil) { result in
            switch result {
            case .success(let data):
                success(data)
            case .failure(let failure):
                fail(failure)
            case .none:
                break
            }
        }
    }
}
