//
//  UIColor+.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIColor {
    // init uicolor from hex
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    public func hexDescription(_ includeAlpha: Bool = false) -> String {
        guard self.cgColor.numberOfComponents == 4 else {
            return "Color not RGB."
        }
        let a = self.cgColor.components!.map { Int($0 * CGFloat(255)) }
        let color = String.init(format: "%02x%02x%02x", a[0], a[1], a[2])
        if includeAlpha {
            let alpha = String.init(format: "%02x", a[3])
            return "\(color)\(alpha)"
        }
        return color.uppercased()
    }
}

extension UIColor {
    
    @nonobjc class var errorRed: UIColor {
        return UIColor(hex: "CC0000")
    }
    
    @nonobjc class var veryLightGray: UIColor {
        return UIColor(white: 0.9, alpha: 1)
    }
    
    @nonobjc class var almostWhiteBackground: UIColor {
        return UIColor(hex: "FEFEFE")
    }
    
    @nonobjc class var midGray: UIColor {
        return UIColor(white: 0.58, alpha: 1)
    }
    
    @nonobjc class var main: UIColor {
        return UIColor(hex: "007AFF")
    }
    
    @nonobjc class var starYellow: UIColor {
        return UIColor(hex: "FFD204")
    }
}
