//
//  UIFont+.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIFont {
    
    class var regular: UIFont {
        if let font = UIFont(name: "AvenirNext", size: 17) {
            return font
        }
        return UIFont.systemFont(ofSize: 17)
    }
    
    class var demiBold: UIFont {
        if let font = UIFont(name: "AvenirNext-DemiBold", size: 17) {
            return font
        }
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    class var medium: UIFont {
        if let font = UIFont(name: "AvenirNext-Medium", size: 17) {
            return font
        }
        return UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    class var bold: UIFont {
        if let font = UIFont(name: "AvenirNext-Bold", size: 17) {
            return font
        }
        return UIFont.systemFont(ofSize: 17, weight: .bold)
    }
}
