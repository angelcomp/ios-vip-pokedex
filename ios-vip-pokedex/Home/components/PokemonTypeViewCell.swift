//
//  PokemonTypeView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 30/06/23.
//

import UIKit

class PokemonTypeViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var typeName: String = ""
    
    private lazy var typeTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 12)
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 2
            frame.size.width = 50
            super.frame = frame
        }
      
    }
    
    // MARK: - UITableViewCell Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - private functions
    
    private func addComponents() {
        contentView.addSubview(typeTitle)
    }
    
    private func addComponentsConstraints() {
        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            typeTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 2),
            typeTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -2),
            typeTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -2)
        ])
    }
    
    private func loadScreenValues() {
        backgroundColor = .white
        alpha = 0.6
        typeTitle.text = typeName
    }
}
