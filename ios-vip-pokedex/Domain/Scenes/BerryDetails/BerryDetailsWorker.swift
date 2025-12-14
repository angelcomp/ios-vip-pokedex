//
//  BerryDetailsWorker.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

protocol BerryDetailsWorkerLogic {
    func fetchData(_ itemUrl: String, completion: @escaping () -> Void)
}

final class BerryDetailsWorker: BerryDetailsWorkerLogic {
    func fetchData(_ itemUrl: String, completion: @escaping () -> Void) {
        
    }
    
    func fetchData() {}
}
