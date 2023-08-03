//
//  PokemonAboutCellView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 02/08/23.
//

import UIKit

class PokemonAboutCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var aboutTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
        element.text = name
        element.textColor = .gray
        element.textAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var aboutValue: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
        element.text = value
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var name: String = ""
    var value: String = ""
    
    // MARK: - lifecycle methods
    
    init(name: String, value: String) {
        super.init(frame: .zero)
        self.value = value
        self.name = name
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout methods
    
    private func setup() {
        addComponents()
        addComponentsConstraints()
    }
    
    private func addComponents() {
        addSubview(aboutTitle)
        addSubview(aboutValue)
    }
    
    private func addComponentsConstraints() {
        addAboutTitleConstraints()
        addAboutValueConstraints()
    }
    
    private func addAboutTitleConstraints() {
        NSLayoutConstraint.activate([
            aboutTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            aboutTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4),
            aboutTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            aboutTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: -32),
        ])
    }
    
    private func addAboutValueConstraints() {
        NSLayoutConstraint.activate([
            aboutValue.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            aboutValue.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4),
            aboutValue.leadingAnchor.constraint(equalTo: aboutTitle.trailingAnchor, constant: 8),
            aboutValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -4),
        ])
    }
}
