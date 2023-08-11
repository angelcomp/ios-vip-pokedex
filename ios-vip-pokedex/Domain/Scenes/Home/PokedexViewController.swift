//
//  PokedexViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol PokedexDisplayLogic: AnyObject {
    func displayScreenValues(_ viewModel: Pokedex.Model.PokemonViewModel)
    func presentScreenError()
}

final class PokedexViewController: UIViewController, PokedexDisplayLogic {

    private var pokemonsList: [Pokemon] = []
    
    // MARK: - Archtecture Objects
    
    var interactor: PokedexBusinessLogic?
    var router: (NSObjectProtocol & PokedexRoutingLogic & PokedexDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private let pokedexView = PokedexView()
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = PokedexInteractor()
        let presenter = PokedexPresenter()
        let router = PokedexRouter()
        
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
        self.view = pokedexView
        
        pokedexView.addComponents()
        pokedexView.addComponentsConstraints()
        
        pokedexView.delegate = self
        
        pokedexView.pokemonsTable.delegate = self
        pokedexView.pokemonsTable.dataSource = self
        
        pokedexView.pageButtonsBar.delegate = self
    }
    
    // MARK: - Display Logic
    
    internal func loadScreenValues() {
        pokedexView.pageButtonsBar.setPageValues(first: 1, last: 2)
        interactor?.loadScreenValues(pokedexView.offset, pokedexView.limit, pokedexView.isIncreasingSort)
    }
    
    internal func presentScreenError() {
        DispatchQueue.main.async {
            self.pokedexView.filter.removeFromSuperview()
            self.pokedexView.loading.stopAnimating()
            self.pokedexView.addErrorStateConstraints()
        }
    }
    
    internal func displayScreenValues(_ viewModel: Pokedex.Model.PokemonViewModel) {
        pokedexView.addSubview(pokedexView.pokemonsTable)
        pokedexView.addPokemonsTableConstraints()
        
        pokedexView.addSubview(pokedexView.pageButtonsBar)
        pokedexView.pageButtonsBar.setPageValues(
            first: pokedexView.offset - pokedexView.limit + 1,
            last: pokedexView.offset
        )
        
        pokedexView.addPageButtonsBarConstraints()
        
        DispatchQueue.main.async {
            self.pokemonsList = viewModel.pokemons
            self.pokedexView.pokemonsTable.reloadData()
        }
        
        pokedexView.loading.removeFromSuperview()
        pokedexView.loading.stopAnimating()
    }
}

// MARK: - pokedexViewController extensions

extension PokedexViewController: PokedexViewDelegate {
    func showFilter(_ filter: UIImageView) {
        let vc = FilterModalViewController(sliderValue: pokedexView.limit, isIncreasingSortType: pokedexView.isIncreasingSort)
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

extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension PokedexViewController: UIPopoverPresentationControllerDelegate, FilterModalViewProtocol {
    func reloadPokemonsList(amount: Int, increasingSort: Bool) {
        pokedexView.removeTableViewAndPageButtons()
        
        pokedexView.limit = amount
        pokedexView.offset = amount
        self.pokedexView.isIncreasingSort = increasingSort
        self.interactor?.loadScreenValues(pokedexView.offset, pokedexView.limit, pokedexView.isIncreasingSort)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension PokedexViewController: PokedexPageButtonsProtocol {
    func goToPreviousPageButton() {
        pokedexView.removeTableViewAndPageButtons()
        pokedexView.offset -= pokedexView.limit
        interactor?.loadScreenValues(pokedexView.offset, pokedexView.limit, pokedexView.isIncreasingSort)
    }
    
    func goToNextPageButton() {
        pokedexView.removeTableViewAndPageButtons()
        pokedexView.offset += pokedexView.limit
        interactor?.loadScreenValues(pokedexView.offset, pokedexView.limit, pokedexView.isIncreasingSort)
    }
}
