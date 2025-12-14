//
//  BerryDetailsViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

protocol BerryDetailsDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: BerryDetails.Model.ViewModel)
}

final class BerryDetailsViewController: UIViewController, BerryDetailsDisplayLogic {
    
    // MARK: - Archtecture Objects
    
    var interactor: BerryDetailsBusinessLogic?
    var router: (NSObjectProtocol & BerryDetailsRoutingLogic & BerryDetailsDataPassing)?
    
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
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = BerryDetailsInteractor()
        let presenter = BerryDetailsPresenter()
        let router = BerryDetailsRouter()
        
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
    
    func displayScreenValues(viewModel: BerryDetails.Model.ViewModel) {
        let detailsView = BerryDetailsView()
        detailsView.setup(berry: viewModel)
        
        view = detailsView
        view.backgroundColor = .lightGray
    }
}
