//
//  UIColor+Ext.swift
//  MagicApp
//
//  Created by Cường Trần on 14/09/2023.
//

import SwiftUI

extension UIColor {
    convenience public init(hex: String) {
        var sanitizedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        sanitizedHex = sanitizedHex.replacingOccurrences(of: "#", with: "")
        
        let scanner = Scanner(string: sanitizedHex)
        var rgb: UInt64 = 0
        
        guard scanner.scanHexInt64(&rgb) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0) // Return black for invalid input
            return
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
