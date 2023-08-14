//
//  BerriesWorker.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesWorkerLogic {
    func fetchBerry(_ id: String, success: @escaping(Berry) -> Void, fail: @escaping() -> Void)
}

final class BerriesWorker: BerriesWorkerLogic {
    
    var apiManager: ApiManager = ApiManager()
    
    func fetchBerry(_ id: String, success: @escaping (Berry) -> Void, fail: @escaping () -> Void) {
        apiManager.getBerry(endpoint: "/berry/\(id)", params: nil) { result in
            switch result {
            case .success(let data):
                success(data)
                break
            case .some:
                fail()
                break
            case .none:
                fail()
                break
            }
        }
    }
}
