//
//  BerriesPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesPresentationLogic {
    func presentScreenValues(_ response: [Berry])
    func presentScreenError()
}

final class BerriesPresenter: BerriesPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerriesDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
    }
    
    func presentScreenValues(_ response: [Berry]) {
        
        let orderedList = response.sorted {
            $0.id < $1.id
        }
        let viewModel = Berries.Model.ViewModel(berries: orderedList)
        viewController?.displayScreenValues(viewModel: viewModel)
        
    }
    
    func presentScreenError() {
        viewController?.presentScreenError()
    }
}
