//
//  HomePageButtonsView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 11/07/23.
//

import UIKit

protocol HomePageButtonsProtocol {
    func goToPreviousPageButton()
    func goToNextPageButton()
}

class HomePageButtonsView: UIView {

    private lazy var pageNumber: UILabel = {
        let element = UILabel()
        element.text = ""
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var previousPage: UIImageView = {
        let image = UIImage(systemName: "arrowshape.turn.up.backward.fill")
        let element = UIImageView(image: image)
        element.tintColor = .black
        element.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPreviousButton))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var nextPage: UIImageView = {
        let image = UIImage(systemName: "arrowshape.turn.up.forward.fill")
        let element = UIImageView(image: image)
        element.tintColor = .black
        element.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapNextButton))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var delegate: HomePageButtonsProtocol?
    
    var firstPokemon: Int?
    var lastPokemon: Int?
    
    // MARK: - Lifecycle functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - public functions
    
    func setPageValues(first: Int, last: Int) {
        firstPokemon = first
        lastPokemon = last
    }
    
    // MARK: - private functions
    
    @objc private func didTapNextButton() {
        delegate?.goToNextPageButton()
    }
    
    @objc private func didTapPreviousButton() {
        delegate?.goToPreviousPageButton()
    }
    
    private func loadScreenValues() {
        
        if let first = firstPokemon,
           let last = lastPokemon {
            pageNumber.text = "\(first) - \(last)"
            
            let diff = last - first
            if last + diff > 1000 { //1000 = max number of pokemon available
                nextPage.isHidden = true
            } else {
                nextPage.isHidden = false
            }
            
        } else {
            previousPage.isHidden = true
            nextPage.isHidden = true
            pageNumber.isHidden = true
        }
        
        if firstPokemon == 1 {
            previousPage.isHidden = true
        } else {
            previousPage.isHidden = false
        }
        
        
    }
    
    private func addComponents() {
        addSubview(pageNumber)
        addSubview(previousPage)
        addSubview(nextPage)
    }
    
    private func addComponentsConstraints() {
        addNumberPageConstraints()
        addPreviousPageConstraints()
        addNextPageConstraints()
    }
    
    private func addNumberPageConstraints() {
        NSLayoutConstraint.activate([
            pageNumber.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageNumber.topAnchor.constraint(equalTo: self.topAnchor),
            pageNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    private func addPreviousPageConstraints() {
        NSLayoutConstraint.activate([
            previousPage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            previousPage.trailingAnchor.constraint(equalTo: pageNumber.leadingAnchor, constant: -12)
        ])
    }
    
    private func addNextPageConstraints() {
        NSLayoutConstraint.activate([
            nextPage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nextPage.leadingAnchor.constraint(equalTo: pageNumber.trailingAnchor, constant: 12)
        ])
    }
}
