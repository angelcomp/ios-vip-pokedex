//
//  HomeViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayScreenValues(_ viewModel: Home.Model.PokemonViewModel)
    func presentScreenError()
}

final class HomeViewController: UIViewController, HomeDisplayLogic {

    private var pokemonsList: [Pokemon] = []
    
    // MARK: - Archtecture Objects
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private let homeView = HomeView()
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        setupView()
        loadScreenValues()
    }
    
    private func setupView() {
        self.view = homeView
        
        homeView.addComponents()
        homeView.addComponentsConstraints()
        
        homeView.delegate = self
        
        homeView.pokemonsTable.delegate = self
        homeView.pokemonsTable.dataSource = self
        
        homeView.pageButtonsBar.delegate = self
    }
    
    // MARK: - Display Logic
    
    internal func loadScreenValues() {
        homeView.pageButtonsBar.setPageValues(first: 1, last: 2)
        interactor?.loadScreenValues(homeView.offset, homeView.limit, homeView.isIncreasingSort)
    }
    
    internal func presentScreenError() {
        DispatchQueue.main.async {
            self.homeView.filter.removeFromSuperview()
            self.homeView.loading.stopAnimating()
            self.homeView.addErrorStateConstraints()
        }
    }
    
    internal func displayScreenValues(_ viewModel: Home.Model.PokemonViewModel) {
        homeView.addSubview(homeView.pokemonsTable)
        homeView.addPokemonsTableConstraints()
        
        homeView.addSubview(homeView.pageButtonsBar)
        homeView.pageButtonsBar.setPageValues(
            first: homeView.offset - homeView.limit + 1,
            last: homeView.offset
        )
        
        homeView.addPageButtonsBarConstraints()
        
        DispatchQueue.main.async {
            self.pokemonsList = viewModel.pokemons
            self.homeView.pokemonsTable.reloadData()
        }
        
        homeView.loading.removeFromSuperview()
        homeView.loading.stopAnimating()
    }
}

// MARK: - HomeViewController extensions

extension HomeViewController: HomeViewDelegate {
    func showFilter(_ filter: UIImageView) {
        let vc = FilterModalViewController(sliderValue: homeView.limit, isIncreasingSortType: homeView.isIncreasingSort)
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = .init(width: 500, height: 300)
        vc.popoverPresentationController?.sourceView = self.view    // the view of the popover
        vc.popoverPresentationController?.sourceRect = CGRect(    // the place to display the popover
            origin: CGPoint(
                x: filter.frame.maxX,
                y: filter.frame.maxY
            ),
            size: .zero
        )
        vc.popoverPresentationController?.delegate = self
        vc.delegate = self
        vc.popoverPresentationController?.permittedArrowDirections = .up
            present(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCardViewCell", for: indexPath) as? PokemonCardViewCell else { return UICollectionViewCell() }
        cell.setup(pokemonsList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.dataStore?.pokemon = pokemonsList[indexPath.row]
        router?.routeToDetails()
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate, FilterModalViewProtocol {
    func reloadPokemonsList(amount: Int, increasingSort: Bool) {
        homeView.removeTableViewAndPageButtons()
        
        homeView.limit = amount
        homeView.offset = amount
        self.homeView.isIncreasingSort = increasingSort
        self.interactor?.loadScreenValues(homeView.offset, homeView.limit, homeView.isIncreasingSort)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension HomeViewController: HomePageButtonsProtocol {
    func goToPreviousPageButton() {
        homeView.removeTableViewAndPageButtons()
        homeView.offset -= homeView.limit
        interactor?.loadScreenValues(homeView.offset, homeView.limit, homeView.isIncreasingSort)
    }
    
    func goToNextPageButton() {
        homeView.removeTableViewAndPageButtons()
        homeView.offset += homeView.limit
        interactor?.loadScreenValues(homeView.offset, homeView.limit, homeView.isIncreasingSort)
    }
}
