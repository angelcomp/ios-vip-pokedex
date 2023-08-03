//
//  PokemonDetailsViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 20/07/23.
//

import UIKit

protocol PokemonDetailsDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: PokemonDetails.Model.ViewModel)
}

final class PokemonDetailsViewController: UIViewController, PokemonDetailsDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: PokemonDetailsBusinessLogic?
    var router: (NSObjectProtocol & PokemonDetailsRoutingLogic & PokemonDetailsDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PokemonDetailsInteractor()
        let presenter = PokemonDetailsPresenter()
        let router = PokemonDetailsRouter()

        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {}
    
    private func addComponentsConstraints() {}
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: PokemonDetails.Model.ViewModel) {
        let detailsView = PokemonDetailsView()
        detailsView.setup(pokemon: viewModel)
        view = detailsView
        view.backgroundColor = UIColor.PokemonColorType.parsePokemonColor(
            type: viewModel.types[0]
        )
        navigationController?.navigationBar.tintColor = .black
    }
}
