//
//  BerryDetailsPresenter.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 14/08/23.
//

import UIKit

protocol BerryDetailsPresentationLogic {
    func presentScreenValues(_ berry: Berry?, _ imageData: Data?)
}

final class BerryDetailsPresenter: BerryDetailsPresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: BerryDetailsDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(_ berry: Berry?, _ imageData: Data?) {
        if let id = berry?.id,
           let name = berry?.name.capitalized,
            let firmness = berry?.firmness,
            let flavors = berry?.flavors,
            let size = berry?.size,
            let smoothness = berry?.smoothness,
           let soilDryness = berry?.soilDryness {
            
            let viewModel = BerryDetails.Model.ViewModel(id: id, name: name, firmness: firmness, flavors: flavors, size: size, smoothness: smoothness, soilDryness: soilDryness, imageData: imageData)
            
            viewController?.displayScreenValues(viewModel: viewModel)
        }
        
        
        
        func printNum() {
//            let al = Alpha()
//            
//            al.teste(.um)
        }
    }
}
