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
    
    private lazy var homeTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        let attributedString = NSMutableAttributedString(string: "Pokédex")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        element.attributedText = attributedString
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var filter: UIImageView = {
        let image = UIImage(systemName: "slider.horizontal.3")
        let element = UIImageView(image: image)
        element.tintColor = .black
        element.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFilter))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokeballImage: UIImageView = {
        let image = UIImage(named: "pokeball")
        let element = UIImageView(image: image)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView(style: .large)
        element.startAnimating()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonsTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 180, height: 220)
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 8
        element.dataSource = self
        element.delegate = self
        element.register(PokemonCardViewCell.self, forCellWithReuseIdentifier: "PokemonCardViewCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var errorLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 30)
        element.text = "Something\nwent wrong :("
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let element = UIButton()
        element.setTitle("Try again", for: .normal)
        element.backgroundColor = .black
        element.titleLabel?.textColor = .white
        element.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTryAgainButton))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pageButtonsBar: HomePageButtonsView = {
        let element = HomePageButtonsView()
        element.delegate = self
        element.firstPokemon = offset - limit + 1
        element.lastPokemon = offset
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var pokemonsList: [Pokemon] = []
    private var limit = 20
    private var offset = 20
    private var isIncreasingSort = true
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
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
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapFilter() {
        let vc = FilterModalViewController(sliderValue: limit, isIncreasingSortType: isIncreasingSort)
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
    
    @objc private func didTapTryAgainButton() {
        removeErrorStateView()
        loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func loadScreenValues() {
        pageButtonsBar.setPageValues(first: 1, last: 2)
        interactor?.loadScreenValues(offset, limit, isIncreasingSort)
    }
    
    private func addComponents() {
        view.addSubview(homeTitle)
        view.addSubview(pokeballImage)
        view.addSubview(filter)
        view.addSubview(loading)
    }
    
    private func addComponentsConstraints() {
        addHomeTitleConstraints()
        addPokeballImageConstraints()
        addFilterConstraints()
        addLoadingConstraints()
    }
    
    private func addHomeTitleConstraints() {
        NSLayoutConstraint.activate([
            homeTitle.centerYAnchor.constraint(equalTo: pokeballImage.centerYAnchor, constant: 32),
            homeTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func addPokeballImageConstraints() {
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -100),
            pokeballImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 64)
        ])
    }
    
    private func addFilterConstraints() {
        NSLayoutConstraint.activate([
            filter.centerYAnchor.constraint(equalTo: homeTitle.centerYAnchor),
            filter.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filter.widthAnchor.constraint(equalToConstant: 30),
            filter.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    private func addLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    private func addErrorStateConstraints() {
        view.addSubview(errorLabel)
        view.addSubview(tryAgainButton)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 32),
            tryAgainButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 64),
            tryAgainButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -64),
        ])
    }
    
    private func addPokemonsTableConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTable.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 8),
            pokemonsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pokemonsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func addPageButtonsBarConstraints() {
        NSLayoutConstraint.activate([
            pageButtonsBar.topAnchor.constraint(equalTo: pokemonsTable.bottomAnchor, constant: 8),
            pageButtonsBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pageButtonsBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pageButtonsBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(_ viewModel: Home.Model.PokemonViewModel) {
        view.addSubview(pokemonsTable)
        addPokemonsTableConstraints()
        
        view.addSubview(pageButtonsBar)
        pageButtonsBar.setPageValues(
            first: offset - limit + 1,
            last: offset
        )
        
        addPageButtonsBarConstraints()
        
        DispatchQueue.main.async {
            self.pokemonsList = viewModel.pokemons
            self.pokemonsTable.reloadData()
        }
        
        loading.removeFromSuperview()
        loading.stopAnimating()
    }
    
    func presentScreenError() {
        DispatchQueue.main.async {
            self.filter.removeFromSuperview()
            self.loading.stopAnimating()
            self.addErrorStateConstraints()
        }
    }
    
    private func removeTableViewAndPageButtons() {
        pokemonsTable.setContentOffset(CGPointZero, animated: true)
        pokemonsTable.removeFromSuperview()
        pageButtonsBar.removeFromSuperview()
        
        view.addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
    
    private func removeErrorStateView() {
        errorLabel.removeFromSuperview()
        tryAgainButton.removeFromSuperview()
        
        view.addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
}

// MARK: - HomeViewController extensions

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCardViewCell", for: indexPath) as? PokemonCardViewCell else { return UICollectionViewCell() }
        cell.setup(pokemonsList[indexPath.row])
        return cell
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate, FilterModalViewProtocol {
    func reloadPokemonsList(amount: Int, increasingSort: Bool) {
        removeTableViewAndPageButtons()
        
        limit = amount
        offset = amount
        self.isIncreasingSort = increasingSort
        self.interactor?.loadScreenValues(offset, limit, isIncreasingSort)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

extension HomeViewController: HomePageButtonsProtocol {
    func goToPreviousPageButton() {
        removeTableViewAndPageButtons()
        offset -= limit
        interactor?.loadScreenValues(offset, limit, isIncreasingSort)
    }
    
    func goToNextPageButton() {
        removeTableViewAndPageButtons()
        offset += limit
        interactor?.loadScreenValues(offset, limit, isIncreasingSort)
    }
}
