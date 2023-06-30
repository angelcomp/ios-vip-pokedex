//
//  HomeViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 28/06/23.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Home.Model.ViewModel)
}

final class HomeViewController: UIViewController, HomeDisplayLogic {
    
    private lazy var homeTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        let attributedString = NSMutableAttributedString(string: "Pokedex")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        element.attributedText = attributedString
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokeballImage: UIImageView = {
        let image = UIImage(named: "pokeball")
        let element = UIImageView(image: image)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonsTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 180, height: 234)
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
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        view.addSubview(homeTitle)
        view.addSubview(pokeballImage)
        view.addSubview(pokemonsTable)
    }
    
    private func addComponentsConstraints() {
        addHomeTitleConstraints()
        addPokeballImageConstraints()
        addPokemonsTableConstraints()
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
    
    private func addPokemonsTableConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTable.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 8),
            pokemonsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pokemonsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pokemonsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCardViewCell", for: indexPath) as? PokemonCardViewCell else { return UICollectionViewCell() }
        return cell
    }
}
