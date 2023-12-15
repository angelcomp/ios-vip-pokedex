//
//  PokemonBaseStatsView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 24/07/23.
//

import UIKit

class PokemonBaseStatsCellView: UIView {
    
    // MARK: - Properties
    
    private lazy var statsTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
        element.text = name
        element.textColor = .gray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var statsValue: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 16)
        element.text = String(value)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var statsProgress: UIProgressView = {
        let element = UIProgressView(progressViewStyle: .bar)
        element.progressTintColor = color
        element.progress = Float(value) / 120
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var name: String = ""
    var value: Int = 0
    var color: UIColor = UIColor()
    
    // MARK: - lifecycle methods
    
    init(name: String, value: Int, color: UIColor) {
        super.init(frame: .zero)
        self.value = value
        self.name = name
        self.color = color
        
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
        addSubview(statsTitle)
        addSubview(statsValue)
        addSubview(statsProgress)
    }
    
    private func addComponentsConstraints() {
        addStatsTitleConstraints()
        addStatsValueConstraints()
        addStatsProgressConstraints()
    }
    
    private func addStatsTitleConstraints() {
        NSLayoutConstraint.activate([
            statsTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            statsTitle.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4),
            statsTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 4),
            statsTitle.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func addStatsValueConstraints() {
        NSLayoutConstraint.activate([
            statsValue.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            statsValue.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4),
            statsValue.leadingAnchor.constraint(equalTo: statsTitle.trailingAnchor, constant: 4),
            statsValue.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func addStatsProgressConstraints() {
        NSLayoutConstraint.activate([
            statsProgress.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            statsProgress.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 4),
            statsProgress.leadingAnchor.constraint(equalTo: statsValue.trailingAnchor, constant: 8),
            statsProgress.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 4),
        ])
    }
}
