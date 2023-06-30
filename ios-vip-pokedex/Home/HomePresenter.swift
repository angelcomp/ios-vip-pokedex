//
//  HomePresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomePresentationLogic {
    func presentScreenValues()
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        let viewModel = Home.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
