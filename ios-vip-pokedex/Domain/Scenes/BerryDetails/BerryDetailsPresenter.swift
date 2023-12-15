//
//  BerryDetailsPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

protocol BerryDetailsPresentationLogic {
    func presentScreenValues()
}

final class BerryDetailsPresenter: BerryDetailsPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerryDetailsDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = BerryDetails.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
