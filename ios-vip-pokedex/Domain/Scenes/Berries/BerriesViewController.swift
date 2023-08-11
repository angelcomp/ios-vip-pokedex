//
//  BerriesViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Berries.Model.ViewModel)
}

final class BerriesViewController: UIViewController, BerriesDisplayLogic {
    
    // MARK: - Archtecture Objects
    private let berriesView = BerriesView()
    
    // MARK: - Archtecture Objects
    
    var interactor: BerriesBusinessLogic?
    var router: (NSObjectProtocol & BerriesRoutingLogic & BerriesDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = BerriesInteractor()
        let presenter = BerriesPresenter()
        let router = BerriesRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        self.view = berriesView
        
        berriesView.addComponents()
        berriesView.addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Berries.Model.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
