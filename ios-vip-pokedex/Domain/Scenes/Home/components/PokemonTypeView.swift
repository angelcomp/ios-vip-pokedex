//
//  PokemonTypeView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 30/06/23.
//

import UIKit

class PokemonTypeView: UIView {
    
    // MARK: - Properties
    
    var typeName: String = ""
    
    private lazy var typeTitle: UILabel = {
        let element = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 12)
        element.textAlignment = .center
        element.text = ""
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
    
    init(typeName: String) {
        self.typeName = typeName
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 4
        backgroundColor = .white
        alpha = 0.6
        
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        addSubview(typeTitle)
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
        typeTitle.text = typeName
    }
}
