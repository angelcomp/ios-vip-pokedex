//
//  FilterModalViewController.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 10/07/23.
//

import UIKit

protocol FilterModalViewProtocol {
    func reloadPokemonsList(amount: Int, increasingSort: Bool)
}

class FilterModalViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var modalTitle: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 24)
        element.text = "Select the order and amount of Pokémons that will be displayed"
        element.textAlignment = .center
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var listSortType: UISegmentedControl = {
        let element = UISegmentedControl(items: ["Increasing", "Decreasing"])
        element.selectedSegmentIndex = isIncreasingSortType ? 0 : 1
        element.tintColor = .black
        element.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var valueSlider: UISlider = {
        let element = UISlider()
        element.minimumValue = 10
        
        element.maximumValue = 100
        element.value = Float(sliderValue)
        element.tintColor = .black
        element.addTarget(self, action: #selector(sliderValueChanged), for: .allEvents)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var valueLabel: UILabel = {
        let element = UILabel()
        element.font = UIFont(name: FontsEnum.chalkboard.rawValue, size: 18)
        element.text = "\(sliderValue)"
        element.textAlignment = .center
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var confirmButton: UIButton = {
        let element = UIButton()
        element.setTitle("Confirm", for: .normal)
        element.backgroundColor = .black
        element.titleLabel?.textColor = .white
        element.layer.cornerRadius = 8
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        element.addGestureRecognizer(tap)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    var sliderValue: Int
    var delegate: FilterModalViewProtocol?
    var isIncreasingSortType = true
    
    // MARK: - UIViewController Lifecycle
    
    init(sliderValue: Int, isIncreasingSortType: Bool) {
        self.sliderValue = sliderValue
        self.isIncreasingSortType = isIncreasingSortType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addComponents()
        addComponentsConstraints()
    }
    
    // MARK: - Layout Functions
    
    @objc private func didTapButton() {
        dismiss(animated: true)
        delegate?.reloadPokemonsList(amount: sliderValue, increasingSort: isIncreasingSortType)
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            isIncreasingSortType = true
        } else {
            isIncreasingSortType = false
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        sliderValue = roundedValue
        valueLabel.text = "\(sliderValue)"
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        view.addSubview(modalTitle)
        view.addSubview(valueLabel)
        view.addSubview(listSortType)
        view.addSubview(valueSlider)
        view.addSubview(confirmButton)
    }
    
    
    private func addComponentsConstraints() {
        addModalTitleConstraints()
        addListSortTypeConstraints()
        addValueLabelConstraints()
        addValueSliderConstraints()
        addConfirmButtonConstraints()
    }
    
    private func addModalTitleConstraints() {
        NSLayoutConstraint.activate([
            modalTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            modalTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            modalTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    private func addListSortTypeConstraints() {
        NSLayoutConstraint.activate([
            listSortType.topAnchor.constraint(equalTo: modalTitle.bottomAnchor),
            listSortType.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            listSortType.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    private func addValueLabelConstraints() {
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: listSortType.bottomAnchor, constant: 16),
            valueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    private func addValueSliderConstraints() {
        NSLayoutConstraint.activate([
            valueSlider.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            valueSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            valueSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    private func addConfirmButtonConstraints() {
        NSLayoutConstraint.activate([
            confirmButton.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: 12),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 64),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -64),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}
