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
    
    private lazy var BerryStatsCard: BerryStatsView = {
        let element = BerryStatsView()
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
        berryName.attributedText = .formatFontSpacing(text: berry.name)
        berryId.text = String(berry.id)
        
        DispatchQueue.main.async {
            
            if let imageData = berry.imageData {
                self.berryImage.image = UIImage(data: imageData)
            } else {
                self.berryImage.image = UIImage(systemName: "wifi-slash")
            }
            
        }
        
        BerryStatsCard.setup(berry)
    }
    
    // MARK: - Layout methods
    
    private func addComponents() {
        addSubview(berryName)
        addSubview(berryId)
        addSubview(berryImage)
        addSubview(BerryStatsCard)
    }
    
    private func addComponentsConstraints() {
        addBerryNameConstraints()
        addBerryIdConstraints()
        addBerryImageConstraints()
        addBerryStatsCardConstraints()
    }
    
    private func addBerryNameConstraints() {
        NSLayoutConstraint.activate([
            berryName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            berryName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            berryName.trailingAnchor.constraint(equalTo: berryId.trailingAnchor, constant: -16),
        ])
    }
    
    private func addBerryIdConstraints() {
        NSLayoutConstraint.activate([
            berryId.centerYAnchor.constraint(equalTo: berryName.centerYAnchor),
            berryId.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    private func addBerryImageConstraints() {
        NSLayoutConstraint.activate([
            berryImage.topAnchor.constraint(equalTo: berryName.bottomAnchor),
//            berryImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            berryImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            berryImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
//        berryImage.setContentHuggingPriority(.notRequired, for: .vertical)
//        berryImage.setContentCompressionResistancePriority(.notRequired, for: .vertical)
//        berryImage.setContentCompressionResistancePriority(.almostRequired, for: .horizontal)
    }
    
    private func addBerryStatsCardConstraints() {
        NSLayoutConstraint.activate([
            BerryStatsCard.topAnchor.constraint(equalTo: berryImage.bottomAnchor),
            BerryStatsCard.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            BerryStatsCard.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            BerryStatsCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16),
        ])
        BerryStatsCard.setContentHuggingPriority(.almostRequired, for: .vertical)
        BerryStatsCard.setContentCompressionResistancePriority(.almostRequired, for: .vertical)
    }
}
