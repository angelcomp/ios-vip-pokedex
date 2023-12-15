//
//  BerryDetailsView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

class BerryDetailsView: UIView {

    private lazy var berryName: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var berryId: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 25)
        element.textAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var berryImage: UIImageView = {
        let element = UIImageView()
        element.dropShadow()
        element.backgroundColor = .clear
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - public methods
    
    func setup(berry: BerryDetails.Model.ViewModel) {
        addComponents()
        addComponentsConstraints()
        loadScreenValues(berry)
    }
    
    // MARK: - private methods
    
    private func loadScreenValues(_ berry: BerryDetails.Model.ViewModel) {
//        berryName.attributedText = .formatFontSpacing(text: berry.name)
//        berryId.text = String(berry.id)
        
//        DispatchQueue.global(qos: .default).async { [weak self] in
//            guard let self = self else { return }
//
//            if let url = URL(string: pokemon.sprite),
//               let data = try? Data(contentsOf: url)
//            {
//                DispatchQueue.main.async {
//                    self.pokemonImage.image = UIImage(data: data)
//                }
//            }
//        }
//
//        pokemon.types.forEach({ type in
//            let typeView = PokemonTypeView(typeName: type.capitalized, fontSize: 20)
//            pokemonTypesStack.addArrangedSubview(typeView)
//        })
//
//        pokemonStatsCard.setup(pokemon)
    }
    
    // MARK: - Layout methods
    
    private func addComponents() {
        addSubview(berryName)
        addSubview(berryId)
        addSubview(berryImage)
    }
    
    private func addComponentsConstraints() {
        addPokemonNameConstraints()
        addPokemonIdConstraints()
        addPokemonImageConstraints()
    }
    
    private func addPokemonNameConstraints() {
        NSLayoutConstraint.activate([
            berryName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            berryName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    private func addPokemonIdConstraints() {
        NSLayoutConstraint.activate([
            berryId.centerYAnchor.constraint(equalTo: berryName.centerYAnchor),
            berryId.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            berryId.leadingAnchor.constraint(equalTo: berryName.trailingAnchor, constant: -8),
            
        ])
    }
    
    private func addPokemonImageConstraints() {
        NSLayoutConstraint.activate([
//            berryImage.topAnchor.constraint(equalTo: berryTypesStack.bottomAnchor),
            berryImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            berryImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        berryImage.setContentHuggingPriority(.notRequired, for: .vertical)
        berryImage.setContentCompressionResistancePriority(.notRequired, for: .vertical)
        berryImage.setContentCompressionResistancePriority(.almostRequired, for: .horizontal)
    }

}
