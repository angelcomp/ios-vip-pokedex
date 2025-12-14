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
    var berry: Berry? { get set }
}

final class BerryDetailsInteractor: BerryDetailsBusinessLogic, BerryDetailsDataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: BerryDetailsPresentationLogic?
    let worker: BerryDetailsWorkerLogic
    
    // MARK: - DataStore Objects
    var berry: Berry?
    
    
    // MARK: - Interactor Lifecycle
    
    init(worker: BerryDetailsWorkerLogic = BerryDetailsWorker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        let imageData = downloadImage(berryName: berry?.name)
        presenter?.presentScreenValues(berry, imageData)
    }
    
    func downloadImage(berryName: String?) -> Data? {
        guard let name = berryName else { return nil }
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(name)-berry.png"
        
        guard let url = URL(string: url),
           let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
    
//    private func doawnloadImage() {
//        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(berry?.name ?? "")-berry.png"
//        DispatchQueue.global(qos: .default).async { [weak self] in
//            guard let self = self else { return }
//            
//            if let url = URL(string: url),
//               let data = try? Data(contentsOf: url)
//            {
//                self.updateScreen(data)
//            } else {
//                self.cardBerryImage.image =
//            }
//        }
//    }
}
