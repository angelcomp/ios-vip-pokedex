//
//  BerriesViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Berries.Model.ViewModel)
    func presentScreenError()
}

final class BerriesViewController: UIViewController, BerriesDisplayLogic, BerriesViewDelegate {
    
    private var berries: [Berry] = []
    
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
    
    private let berriesView = BerriesView()
    
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
        
        setupView()
    }
    
    private func setupView() {
        
        self.view = berriesView
        
        berriesView.addComponents()
        berriesView.addComponentsConstraints()
        loadScreenValues()
        
        berriesView.delegate = self
        
        berriesView.berriesTable.delegate = self
        berriesView.berriesTable.dataSource = self
    }
    
    // MARK: - Private Functions
    
    internal func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Display Logic
    
    
    internal func presentScreenError() {
        DispatchQueue.main.async {
            self.berriesView.loading.stopAnimating()
            self.berriesView.addErrorStateConstraints()
        }
    }
    
    internal func displayScreenValues(viewModel: Berries.Model.ViewModel) {
        berriesView.addSubview(berriesView.berriesTable)
        berriesView.addBerriesTableConstraints()
        
        DispatchQueue.main.async {
            self.berries = viewModel.berries
            self.berriesView.berriesTable.reloadData()
        }
        
        berriesView.loading.removeFromSuperview()
        berriesView.loading.stopAnimating()
    }
}

extension BerriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        berries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView .dequeueReusableCell(withIdentifier: "BerryCardViewCell", for: indexPath) as? BerryCardViewCell else { return UITableViewCell() }
        cell.setup(berries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
