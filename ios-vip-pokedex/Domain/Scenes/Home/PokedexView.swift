//
//  PokedexView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 03/08/23.
//

import UIKit

protocol PokedexViewDelegate {
    func showFilter(_ filter: UIImageView)
    func loadScreenValues()
}

internal class PokedexView: UIView {
    
    // MARK: - Properties
    
    internal lazy var homeTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        let attributedString = NSMutableAttributedString(string: "Pokédex")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        element.attributedText = attributedString
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var filter: UIImageView = {
        let image = UIImage(systemName: "slider.horizontal.3")
        let element = UIImageView(image: image)
        element.tintColor = .black
        element.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapFilter))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var pokeballImage: UIImageView = {
        let image = UIImage(named: "pokeball")
        let element = UIImageView(image: image)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var loading: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView(style: .large)
        element.startAnimating()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var pokemonsTable: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 180, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        let element = UICollectionView(frame: .zero, collectionViewLayout: layout)
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 8
        element.collectionViewLayout = layout
        element.register(PokemonCardViewCell.self, forCellWithReuseIdentifier: "PokemonCardViewCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var errorLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 30)
        element.text = "Something\nwent wrong :("
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var tryAgainButton: UIButton = {
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
    
    internal lazy var pageButtonsBar: PokedexPageButtonsView = {
        let element = PokedexPageButtonsView()
        element.firstPokemon = offset - limit + 1
        element.lastPokemon = offset
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal var delegate: PokedexViewDelegate?
    internal var limit = 20
    internal var offset = 20
    internal var isIncreasingSort = true
    
    // MARK: - Lifecycle Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = .white
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapFilter() {
        delegate?.showFilter(filter)
    }
    
    @objc private func didTapTryAgainButton() {
        removeErrorStateView()
        delegate?.loadScreenValues()
    }
    
    // MARK: - Display Logic
    
    internal func removeTableViewAndPageButtons() {
        pokemonsTable.setContentOffset(CGPointZero, animated: true)
        pokemonsTable.removeFromSuperview()
        pageButtonsBar.removeFromSuperview()
        
        addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
    
    internal func removeErrorStateView() {
        errorLabel.removeFromSuperview()
        tryAgainButton.removeFromSuperview()
        
        addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
    
    // MARK: - Layout Functions
    
    internal func addComponents() {
        addSubview(pokeballImage)
        addSubview(homeTitle)
        addSubview(filter)
        addSubview(loading)
    }
    
    internal func addComponentsConstraints() {
        addHomeTitleConstraints()
        addPokeballImageConstraints()
        addFilterConstraints()
        addLoadingConstraints()
    }
    
    internal func addHomeTitleConstraints() {
        NSLayoutConstraint.activate([
            homeTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            homeTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    internal func addPokeballImageConstraints() {
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100),
            pokeballImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 64)
        ])
    }
    
    internal func addFilterConstraints() {
        NSLayoutConstraint.activate([
            filter.centerYAnchor.constraint(equalTo: homeTitle.centerYAnchor),
            filter.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            filter.widthAnchor.constraint(equalToConstant: 30),
            filter.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    internal func addLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    internal func addErrorStateConstraints() {
        addSubview(errorLabel)
        addSubview(tryAgainButton)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 32),
            tryAgainButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 64),
            tryAgainButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -64),
        ])
    }
    
    internal func addPokemonsTableConstraints() {
        NSLayoutConstraint.activate([
            pokemonsTable.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 8),
            pokemonsTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pokemonsTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    internal func addPageButtonsBarConstraints() {
        NSLayoutConstraint.activate([
            pageButtonsBar.topAnchor.constraint(equalTo: pokemonsTable.bottomAnchor, constant: 8),
            pageButtonsBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pageButtonsBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pageButtonsBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}
