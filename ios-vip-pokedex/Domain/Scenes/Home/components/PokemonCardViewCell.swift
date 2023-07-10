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
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardFavoriteIcon: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let element = UIImageView(image: image)
        element.alpha = 0.5
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
    
    private lazy var cardTypes: UITableView = {
        let element = UITableView()
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .clear
        element.separatorColor = .clear
        element.dataSource = self
        element.delegate = self
        element.register(PokemonTypeViewCell.self, forCellReuseIdentifier: "PokemonTypeViewCell")
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - public functions
    
    func setup(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    // MARK: - private functions
    
    private func loadScreenValues() {
        backgroundColor = parsePokemonColor(type: "\(pokemon?.types[0].type.name ?? "")")
        layer.cornerRadius = 8
        cardId.text = "#00\(pokemon?.id ?? 0)"
        cardName.text = pokemon?.name.capitalized
        
        DispatchQueue.global(qos: .default).async {
            if let url = URL(string: self.pokemon?.sprites.other.officialArtwork.frontDefault ?? ""),
               let data = try? Data(contentsOf: url)
            {
                self.updateScreen(data)
            } else {
                self.cardPokemonImage.image = UIImage(systemName: "wifi.slash")
            }
        }
    }
    
    private func updateScreen(_ imageData: Data) {
        DispatchQueue.main.async {
            self.cardPokemonImage.image = UIImage(data: imageData)
            self.loading.removeFromSuperview()
            self.loading.stopAnimating()
            self.addSubview(self.cardPokeballImage)
            self.addSubview(self.cardPokemonImage)
            self.addCardPokeballImageConstraints()
            self.addCardPokemonImageConstraints()
        }
    }
    
    private func parsePokemonColor(type: String) -> UIColor {
        switch type {
        case "fighting": return UIColor(named: "fighting")!
        case "flying": return UIColor(named: "flying")!
        case "poison": return UIColor(named: "poison")!
        case "ground": return UIColor(named: "ground")!
        case "rock": return UIColor(named: "rock")!
        case "bug": return UIColor(named: "bug")!
        case "ghost": return UIColor(named: "ghost")!
        case "steel": return UIColor(named: "steel")!
        case "fire": return UIColor(named: "fire")!
        case "water": return UIColor(named: "water")!
        case "grass": return UIColor(named: "grass")!
        case "electric": return UIColor(named: "electric")!
        case "psychic": return UIColor(named: "psychic")!
        case "ice": return UIColor(named: "ice")!
        case "dragon": return UIColor(named: "dragon")!
        case "dark": return UIColor(named: "dark")!
        case "fairy": return UIColor(named: "fairy")!
        default:
            return .lightGray
        }
    }
    
    private func addComponents() {
        addSubview(cardId)
        addSubview(cardFavoriteIcon)
        addSubview(cardName)
        addSubview(cardTypes)
        addSubview(loading)
    }
    
    private func addComponentsConstraints() {
        addCardIdConstraints()
        addCardFavoriteIconConstraints()
        addCardNameConstraints()
        addCardTypesConstraints()
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
    
    private func addCardTypesConstraints() {
        NSLayoutConstraint.activate([
            cardTypes.topAnchor.constraint(equalTo: cardName.bottomAnchor),
            cardTypes.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            cardTypes.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            cardTypes.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
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

extension PokemonCardViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemon?.types.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "PokemonTypeViewCell", for: indexPath) as? PokemonTypeViewCell else { return UITableViewCell() }
        cell.typeName = pokemon?.types[indexPath.row].type.name ?? ""
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
