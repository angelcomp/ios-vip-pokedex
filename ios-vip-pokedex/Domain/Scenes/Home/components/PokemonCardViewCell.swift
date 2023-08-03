//
//  PokemonCardView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 30/06/23.
//

import UIKit
import Foundation

class PokemonCardViewCell: UICollectionViewCell {
    private var pokemon: Pokemon?
    
    private lazy var cardId: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
        element.text = ""
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardFavoriteIcon: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let element = UIImageView(image: image)
        element.tintColor = .red
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardName: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 24)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardTypesStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 4
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardPokeballImage: UIImageView = {
        let image = UIImage(named: "pokeball")
        let element = UIImageView(image: image)
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardPokemonImage: UIImageView = {
        let element = UIImageView()
        element.backgroundColor = .clear
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView(style: .medium)
        element.startAnimating()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - UITableViewCell Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemon = nil
        cardTypesStack.safelyRemoveArrangedSubviews()
        cardPokemonImage.image = nil
        backgroundColor = .white
        loading.startAnimating()
    }
    
    // MARK: - public functions
    
    func setup(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        cardTypesStack.removeFromSuperview()
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - private functions
    
    private func loadScreenValues() {
        backgroundColor = UIColor.PokemonColorType.parsePokemonColor(
            type: "\(pokemon?.types[0].type.name ?? "")"
        )
        
        layer.cornerRadius = 8
        formatIdString(pokemon?.id ?? 0)
        cardName.text = pokemon?.name.capitalized
        
        pokemon?.types.forEach({ pokemonType in
            let typeView = PokemonTypeView(typeName: pokemonType.type.name, fontSize: 12)
            cardTypesStack.addArrangedSubview(typeView)
        })
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            
            if let url = URL(string: self.pokemon?.sprites.other.officialArtwork.frontDefault ?? ""),
               let data = try? Data(contentsOf: url)
            {
                self.updateScreen(data)
            } else {
                self.cardPokemonImage.image = UIImage(systemName: "wifi.slash")
            }
        }
    }
    
    private func formatIdString(_ id: Int?) {
        if let id = id {
            switch id {
            case 1..<10: cardId.text = "#00\(id)"
            case 10..<100: cardId.text = "#0\(id)"
            case 100..<1000: cardId.text = "#\(id)"
            default:
                cardId.text = "#\(id)"
            }
        }
    }
    
    private func updateScreen(_ imageData: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cardPokemonImage.image = UIImage(data: imageData)
            self.loading.removeFromSuperview()
            self.loading.stopAnimating()
            self.addSubview(self.cardPokeballImage)
            self.addSubview(self.cardPokemonImage)
            self.addCardPokeballImageConstraints()
            self.addCardPokemonImageConstraints()
        }
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        addSubview(cardId)
        addSubview(cardFavoriteIcon)
        addSubview(cardName)
        addSubview(cardTypesStack)
        addSubview(loading)
    }
    
    private func addComponentsConstraints() {
        addCardIdConstraints()
        addCardFavoriteIconConstraints()
        addCardNameConstraints()
        addCardTypesStackConstraints()
        addLoadingConstraints()
    }
    
    private func addCardIdConstraints() {
        NSLayoutConstraint.activate([
            cardId.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            cardId.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            cardId.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func addCardFavoriteIconConstraints() {
        NSLayoutConstraint.activate([
            cardFavoriteIcon.centerYAnchor.constraint(equalTo: cardId.centerYAnchor),
            cardFavoriteIcon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
        ])
    }
    
    private func addCardNameConstraints() {
        NSLayoutConstraint.activate([
            cardName.topAnchor.constraint(equalTo: cardId.bottomAnchor, constant: -4),
            cardName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            cardName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func addCardTypesStackConstraints() {
        NSLayoutConstraint.activate([
            cardTypesStack.topAnchor.constraint(equalTo: cardName.bottomAnchor, constant: 4),
            cardTypesStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            cardTypesStack.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func addCardPokeballImageConstraints() {
        NSLayoutConstraint.activate([
            cardPokeballImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            cardPokeballImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
            cardPokeballImage.heightAnchor.constraint(equalToConstant: 120),
            cardPokeballImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func addCardPokemonImageConstraints() {
        NSLayoutConstraint.activate([
            cardPokemonImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -4),
            cardPokemonImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
            cardPokemonImage.heightAnchor.constraint(equalToConstant: 120),
            cardPokemonImage.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func addLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 32),
            loading.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 32),
        ])
    }
}
