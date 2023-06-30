//
//  PokemonCardView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 30/06/23.
//

import UIKit
import Foundation

class PokemonCardViewCell: UICollectionViewCell {
    private var pokemonId: String = "1"
    private var pokemonName: String = "pokemau"
    private var pokemonTypes: [String] = ["Water", "Grass", "bla"]
    private var pokemonImage: String = "asd"
    private var pokemonColor: String = "asd"
    
    private lazy var cardId: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
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
    
    // MARK: - UITableViewCell Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - private functions
    
    private func addComponents() {
        addSubview(cardId)
        addSubview(cardName)
        addSubview(cardTypes)
        addSubview(cardPokeballImage)
        addSubview(cardPokemonImage)
    }
    
    private func loadScreenValues() {
        backgroundColor = .lightGray
        layer.cornerRadius = 8
        cardId.text = "#00\(pokemonId)"
        cardName.text = pokemonName.capitalized
        
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")
        let data = try? Data(contentsOf: url!)
        
        cardPokemonImage.image = UIImage(data: data!)
    }
    
    private func addComponentsConstraints() {
        addCardIdConstraints()
        addCardNameConstraints()
        addCardTypesConstraints()
        addCardPokeballImageConstraints()
        addCardPokemonImageConstraints()
    }
    
    private func addCardIdConstraints() {
        NSLayoutConstraint.activate([
            cardId.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            cardId.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            cardId.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
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
}

extension PokemonCardViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemonTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: "PokemonTypeViewCell", for: indexPath) as? PokemonTypeViewCell else { return UITableViewCell() }
        cell.typeName = pokemonTypes[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
