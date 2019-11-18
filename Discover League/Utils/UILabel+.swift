//
//  UILabel+.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UILabel {
    /// Label with specified font, size, text, color and alignment
    convenience init(font: UIFont, text: String? = nil, fontSize: CGFloat? = nil, textColor: UIColor = .secondaryLabel, textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.text = text
        
        if let size = fontSize {
            self.font = font.withSize(size)
        } else {
            self.font = font
        }
        
        self.textColor = textColor
        
        self.textAlignment = textAlignment
        numberOfLines = 0
    }
}
