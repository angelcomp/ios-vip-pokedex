//
//  NSAttributedString+extension.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 24/07/23.
//

import UIKit

extension NSAttributedString {
    
    static func formatFontSpacing(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(5.0), range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
}
