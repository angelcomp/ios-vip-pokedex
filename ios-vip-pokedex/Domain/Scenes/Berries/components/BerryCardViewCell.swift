//
//  BerryCardViewCell.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

class BerryCardViewCell: UITableViewCell {
    private var berry: Berry?
    
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
    
    private lazy var cardDescription: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 18)
        element.textColor = .gray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - ViewCell Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        berry = nil
        backgroundColor = .white
    }
    
    // MARK: - public functions
    
    func setup(_ berry: Berry) {
        self.berry = berry
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - private functions
    
    private func loadScreenValues() {
        
        layer.cornerRadius = 8
        formatIdString(berry?.id ?? 0)
        cardName.text = berry?.name.capitalized
        cardDescription.text = berry?.firmness.name.replacingOccurrences(of: "-", with: " ").capitalized
    }
    
    private func formatIdString(_ id: Int?) {
        if let id = id {
            switch id {
            case 1..<10: cardId.text = "#0\(id)"
            case 10..<64: cardId.text = "#\(id)"
            default:
                cardId.text = "#\(id)"
            }
        }
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        addSubview(cardId)
        addSubview(cardFavoriteIcon)
        addSubview(cardName)
        addSubview(cardDescription)
    }
    
    private func addComponentsConstraints() {
        addCardIdConstraints()
        addCardFavoriteIconConstraints()
        addCardNameConstraints()
        addCardDescriptionConstraints()
    }
    
    private func addCardIdConstraints() {
        NSLayoutConstraint.activate([
            cardId.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            cardId.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            cardId.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            cardId.trailingAnchor.constraint(equalTo: cardName.leadingAnchor, constant: -16),
        ])
        cardId.setContentHuggingPriority(.almostRequired, for: .horizontal)
    }
    
    private func addCardNameConstraints() {
        NSLayoutConstraint.activate([
            cardName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            cardName.bottomAnchor.constraint(equalTo: cardDescription.topAnchor, constant: -2),
            cardName.trailingAnchor.constraint(equalTo: cardFavoriteIcon.leadingAnchor),
        ])
        cardName.setContentHuggingPriority(.notRequired, for: .horizontal)
    }
    
    private func addCardDescriptionConstraints() {
        NSLayoutConstraint.activate([
            cardDescription.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            cardDescription.leadingAnchor.constraint(equalTo: cardName.leadingAnchor),
        ])
    }
    
    private func addCardFavoriteIconConstraints() {
        NSLayoutConstraint.activate([
            cardFavoriteIcon.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            cardFavoriteIcon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
}
