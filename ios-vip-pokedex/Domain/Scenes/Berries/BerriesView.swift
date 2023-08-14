//
//  BerriesView.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 08/08/23.
//

import UIKit

protocol BerriesViewDelegate {
    func loadScreenValues()
}

class BerriesView: UIView {
    
    // MARK: - Properties
    
    internal lazy var loading: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView(style: .large)
        element.startAnimating()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var viewTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.pokemonSolid.rawValue, size: 40)
        let attributedString = NSMutableAttributedString(string: "Berries")
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        element.attributedText = attributedString
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var berryImage: UIImageView = {
        let image = UIImage(named: "berry")
        let element = UIImageView(image: image)
        element.alpha = 0.15
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var berriesTable: UITableView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 180, height: 210)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.minimumLineSpacing = 12
        let element = UITableView()
        element.showsVerticalScrollIndicator = false
        element.backgroundColor = .white
        element.layer.cornerRadius = 8
        element.register(BerryCardViewCell.self, forCellReuseIdentifier: "BerryCardViewCell")
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var errorLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 30)
        element.text = "Something\nwent wrong :("
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal lazy var tryAgainButton: UIButton = {
        let element = UIButton()
        element.setTitle("Try again", for: .normal)
        element.backgroundColor = .black
        element.titleLabel?.textColor = .white
        element.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTryAgainButton))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    internal var delegate: BerriesViewDelegate?
    internal var isIncreasingSort = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Private Functions
    
    @objc private func didTapTryAgainButton() {
        removeErrorStateView()
        delegate?.loadScreenValues()
    }
    
    // MARK: - Display Logic
    
    internal func removeTableViewAndPageButtons() {
        berriesTable.setContentOffset(CGPointZero, animated: true)
        berriesTable.removeFromSuperview()
        
        addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
    
    internal func removeErrorStateView() {
        errorLabel.removeFromSuperview()
        tryAgainButton.removeFromSuperview()
        
        addSubview(loading)
        addLoadingConstraints()
        loading.startAnimating()
    }
    
    // MARK: - Layout Functions
    
    internal func addComponents() {
        addSubview(berryImage)
        addSubview(viewTitle)
        addSubview(loading)
        
    }
    
    internal func addComponentsConstraints() {
        addHomeTitleConstraints()
        addBerryImageConstraints()
        addLoadingConstraints()
    }
    
    internal func addHomeTitleConstraints() {
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            viewTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
    
    internal func addBerryImageConstraints() {
        NSLayoutConstraint.activate([
            berryImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -100),
            berryImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 32)
        ])
    }
    
    internal func addLoadingConstraints() {
        NSLayoutConstraint.activate([
            loading.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
    internal func addErrorStateConstraints() {
        addSubview(errorLabel)
        addSubview(tryAgainButton)
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            tryAgainButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 32),
            tryAgainButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 64),
            tryAgainButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -64),
        ])
    }
    
    internal func addBerriesTableConstraints() {
        NSLayoutConstraint.activate([
            berriesTable.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 16),
            berriesTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            berriesTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            berriesTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
