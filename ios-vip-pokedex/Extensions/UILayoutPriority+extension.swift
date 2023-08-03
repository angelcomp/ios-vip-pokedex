//
//  UILayoutPriority+extension.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 02/08/23.
//

import UIKit

extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}
