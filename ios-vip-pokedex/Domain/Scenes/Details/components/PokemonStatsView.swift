//
//  PokemonStatsView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 24/07/23.
//

import UIKit

class PokemonStatsView: UIView {
    
    // MARK: - Properties
    
    private lazy var sectionControl: UISegmentedControl = {
        let element = UISegmentedControl(items: ["About", "Base Stats"])
        element.selectedSegmentIndex = 0
        element.tintColor = .black
        element.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var detailedAboutStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var detailedStatsStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 8
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - public methods
    
    func setup(_ pokemon: PokemonDetails.Model.ViewModel) {
        setupStatsStack(pokemon)
        setupAboutStack(pokemon)
        
        backgroundColor = .white
        layer.cornerRadius = 32
        
        setupSectionControlConstraints()
        setupStatsSectionConstraints()
        setupAboutSectionConstraints()
    }
    
    // MARK: - private methods
    
    private func setupStatsStack(_ pokemon: PokemonDetails.Model.ViewModel) {
        
        let color = UIColor.PokemonColorType.parsePokemonColor(
            type: "\(pokemon.types[0])"
        )
        
        var total = 0
        pokemon.stats.forEach { item in
            let element = PokemonBaseStatsCellView(name: item.key, value: item.value, color: color)
            detailedStatsStack.addArrangedSubview(element)
            total += item.value
        }
        total = total / pokemon.stats.count
        let element = PokemonBaseStatsCellView(name: "Average", value: total, color: color)
        detailedStatsStack.addArrangedSubview(element)
        detailedStatsStack.alpha = 0
    }
    
    private func setupAboutStack(_ pokemon: PokemonDetails.Model.ViewModel) {
        var abilitiesString = ""
        
        pokemon.abilities.forEach { ability in
            abilitiesString += ability.capitalized + ", "
        }
        
        let height = PokemonAboutCellView(name: "Height", value: String(pokemon.height))
        let weight = PokemonAboutCellView(name: "Weight", value: String(pokemon.weight))
        let abilities = PokemonAboutCellView(name: "Abilities", value: abilitiesString)
        
        detailedAboutStack.addArrangedSubview(height)
        detailedAboutStack.addArrangedSubview(weight)
        detailedAboutStack.addArrangedSubview(abilities)
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            detailedStatsStack.alpha = 0
            detailedAboutStack.alpha = 1
            
        } else {
            detailedStatsStack.alpha = 1
            detailedAboutStack.alpha = 0
        }
    }
    
    // MARK: - Layout methods
    
    private func setupSectionControlConstraints() {
        addSubview(sectionControl)
        NSLayoutConstraint.activate([
            sectionControl.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            sectionControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            sectionControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
    
    private func setupAboutSectionConstraints() {
        addSubview(detailedAboutStack)

        NSLayoutConstraint.activate([
            detailedAboutStack.topAnchor.constraint(equalTo: sectionControl.bottomAnchor, constant: 16),
            detailedAboutStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            detailedAboutStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
        ])
    }
    
    private func setupStatsSectionConstraints() {
        addSubview(detailedStatsStack)

        NSLayoutConstraint.activate([
            detailedStatsStack.topAnchor.constraint(equalTo: sectionControl.bottomAnchor, constant: 16),
            detailedStatsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            detailedStatsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            detailedStatsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -48)
        ])
    }
}
