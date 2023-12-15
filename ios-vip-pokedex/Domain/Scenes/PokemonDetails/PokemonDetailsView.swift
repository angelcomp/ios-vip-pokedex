//
//  PokemonDetailsView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 24/07/23.
//

import UIKit

class PokemonDetailsView: UIView {
    
    // MARK: - Properties
    
    private lazy var pokemonName: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonId: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 25)
        let attributedString = NSMutableAttributedString(string: "Pokédex")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        element.attributedText = attributedString
        element.textAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonTypesStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = 4
        element.distribution = .fillProportionally
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokeballImage: UIImageView = {
        let image = UIImage(named: "pokeball")
        let element = UIImageView(image: image)
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonImage: UIImageView = {
        let element = UIImageView()
        element.dropShadow()
        element.backgroundColor = .clear
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var pokemonStatsCard: PokemonStatsView = {
        let element = PokemonStatsView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - public methods
    
    func setup(pokemon: PokemonDetails.Model.ViewModel) {
        addComponents()
        addComponentsConstraints()
        loadScreenValues(pokemon)
    }
    
    // MARK: - private methods
    
    private func loadScreenValues(_ pokemon: PokemonDetails.Model.ViewModel) {
        pokemonName.attributedText = .formatFontSpacing(text: pokemon.name)
        pokemonId.text = String(pokemon.id)
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            
            if let url = URL(string: pokemon.sprite),
               let data = try? Data(contentsOf: url)
            {
                DispatchQueue.main.async {
                    self.pokemonImage.image = UIImage(data: data)
                }
            }
        }
        
        pokemon.types.forEach({ type in
            let typeView = PokemonTypeView(typeName: type.capitalized, fontSize: 20)
            pokemonTypesStack.addArrangedSubview(typeView)
        })
        
        pokemonStatsCard.setup(pokemon)
    }
    
    // MARK: - Layout methods
    
    private func addComponents() {
        addSubview(pokemonName)
        addSubview(pokemonId)
        addSubview(pokemonTypesStack)
        addSubview(pokeballImage)
        addSubview(pokemonStatsCard)
        addSubview(pokemonImage)
    }
    
    private func addComponentsConstraints() {
        addPokemonNameConstraints()
        addPokemonIdConstraints()
        addPokemonsTypesStackConstraints()
        addPokemonImageConstraints()
        addPokeballImageConstraints()
        addPokemonStatsCardConstraints()
    }
    
    private func addPokemonNameConstraints() {
        NSLayoutConstraint.activate([
            pokemonName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            pokemonName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func addPokemonIdConstraints() {
        NSLayoutConstraint.activate([
            pokemonId.centerYAnchor.constraint(equalTo: pokemonName.centerYAnchor),
            pokemonId.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            pokemonId.leadingAnchor.constraint(equalTo: pokemonName.trailingAnchor, constant: -8),
            
        ])
    }
    
    private func addPokemonsTypesStackConstraints() {
        NSLayoutConstraint.activate([
            pokemonTypesStack.topAnchor.constraint(equalTo: pokemonName.bottomAnchor, constant: 8),
            pokemonTypesStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            pokemonTypesStack.trailingAnchor.constraint(equalTo: pokemonName.trailingAnchor),
            pokemonTypesStack.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func addPokemonImageConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: pokemonTypesStack.bottomAnchor),
            pokemonImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pokemonImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        pokemonImage.setContentHuggingPriority(.notRequired, for: .vertical)
        pokemonImage.setContentCompressionResistancePriority(.notRequired, for: .vertical)
        pokemonImage.setContentCompressionResistancePriority(.almostRequired, for: .horizontal)
    }
    
    private func addPokeballImageConstraints() {
        NSLayoutConstraint.activate([
            pokeballImage.topAnchor.constraint(equalTo: pokemonTypesStack.bottomAnchor, constant: 16),
            pokeballImage.bottomAnchor.constraint(equalTo: pokemonImage.centerYAnchor, constant: 16),
            pokeballImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 16),
            pokeballImage.leadingAnchor.constraint(equalTo: pokemonImage.centerXAnchor, constant: 16),
        ])
    }
    
    private func addPokemonStatsCardConstraints() {
        NSLayoutConstraint.activate([
            pokemonStatsCard.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: -45),
            pokemonStatsCard.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            pokemonStatsCard.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            pokemonStatsCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
        ])
        pokemonStatsCard.setContentHuggingPriority(.almostRequired, for: .vertical)
        pokemonStatsCard.setContentCompressionResistancePriority(.almostRequired, for: .vertical)
    }
}

