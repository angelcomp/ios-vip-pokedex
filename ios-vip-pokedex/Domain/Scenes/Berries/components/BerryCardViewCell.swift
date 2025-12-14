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
    
    private lazy var cardBerryImage: UIImageView = {
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
    
    // MARK: - ViewCell Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        berry = nil
        cardBerryImage.image = nil
        backgroundColor = .white
        loading.startAnimating()
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
        cardDescription.text = berry?.firmness.replacingOccurrences(of: "-", with: " ").capitalized
        downloadImage()
    }
    
    private func downloadImage() {
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(berry?.name ?? "")-berry.png"
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            
            if let url = URL(string: url),
               let data = try? Data(contentsOf: url)
            {
                self.updateScreen(data)
            } else {
                self.cardBerryImage.image = UIImage(systemName: "wifi.slash")
            }
        }
    }
    
    private func updateScreen(_ imageData: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cardBerryImage.image = UIImage(data: imageData)
            self.loading.removeFromSuperview()
            self.loading.stopAnimating()
            self.addSubview(self.cardBerryImage)
            self.addCardBerryImageConstraints()
        }
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
        addSubview(loading)
    }
    
    private func addComponentsConstraints() {
        addCardIdConstraints()
        addCardFavoriteIconConstraints()
        addCardNameConstraints()
        addCardDescriptionConstraints()
        addLoadingConstraints()
    }
    
    private func addCardIdConstraints() {
        NSLayoutConstraint.activate([
            cardId.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            cardId.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            cardId.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
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
            cardDescription.leadingAnchor.constraint(equalTo: cardName.leadingAnchor),
        ])
    }
    
    private func addCardFavoriteIconConstraints() {
        NSLayoutConstraint.activate([
            cardFavoriteIcon.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            cardFavoriteIcon.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    private func addCardBerryImageConstraints() {
        NSLayoutConstraint.activate([
            cardBerryImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            cardBerryImage.trailingAnchor.constraint(equalTo: cardName.leadingAnchor, constant: -8),
            cardBerryImage.leadingAnchor.constraint(equalTo: cardId.trailingAnchor, constant: 8),
            cardBerryImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            cardBerryImage.heightAnchor.constraint(equalToConstant: 85),
            cardBerryImage.widthAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    private func addLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            loading.trailingAnchor.constraint(equalTo: cardName.leadingAnchor, constant: -8),
            loading.leadingAnchor.constraint(equalTo: cardId.trailingAnchor, constant: 16),
            loading.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            loading.heightAnchor.constraint(equalToConstant: 85),
            loading.widthAnchor.constraint(equalToConstant: 85)
        ])
    }
}
