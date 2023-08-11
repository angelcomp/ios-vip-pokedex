//
//  BerriesPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesPresentationLogic {
    func presentScreenValues()
}

final class BerriesPresenter: BerriesPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerriesDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Berries.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
