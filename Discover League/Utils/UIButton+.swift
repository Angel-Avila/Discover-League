//
//  UIButton+.swift
//  Discover League
//
//  Created by Angel Avila on 17/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIButton {
    /// Button types used throughout the application
    enum DLButtonType {
        /// The button's height and width will be the same and it will be rounded so it is shaped like a circle
        case circular
        
        /// The button's cornerRadius will be equal to half of the button's height so the sides are completely rounded but its width will be 0 (to be set as needed)
        case rounded
        
        /// The button won't have any rounded corners and its width will be 0 (to be set as needed)
        case rectangular
        
        /// The button will have rounded corners with a custom value
        case roundedCorners(value: CGFloat)
    }
    
    /// Type of shadow to be cast to a button
    enum ShadowType {
        /// Casts the UIView function `float()` to the button
        case defaultShadow
                
        /// The button doesn't cast a shadow
        case none
    }
    
    enum CloseButtonStyle {
        case dark
        case light
    }
    
    /// Button with a background color and round corners (cornerRadius = height / 2)
    ///
    /// - Parameters:
    ///   - color: Button's background color
    ///   - height: Button's height. This method will set the frame to this specified value
    ///   - font: Button's `titleLabel` font value
    ///   - textColor: Button's text color
    ///   - title: Button's title label text value
    ///   - buttonType: Type of the button. Default is `.rounded`. Check `TCButtonType` for more info.
    ///   - shadowType: Type of shadow to set to the button. Default is `.`defaultShadow`. Check `TCShadowType` for more info.
    /// - Returns: A `UIButton` with the specified values
    static func colorButton(color: UIColor, height: CGFloat, font: UIFont, textColor: UIColor = .white, localizableTitle title: String? = nil, buttonType: DLButtonType = .circular, shadowType: ShadowType = .defaultShadow) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = color
        
        button.setTitle(title?.localize(), for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        button.titleLabel?.font = font
        
        let frameWidth: CGFloat!
        let frameHeight: CGFloat!
        
        switch buttonType {
        case .circular:
            frameWidth = height
            frameHeight = height
            button.layer.cornerRadius = height/2
        case .rounded:
            frameWidth = 0
            frameHeight = height
            button.layer.cornerRadius = height/2
        case .rectangular:
            frameWidth = 0
            frameHeight = height
        case .roundedCorners(let value):
            frameWidth = 0
            frameHeight = height
            button.layer.cornerRadius = value
        }
        
        switch shadowType {
        case .defaultShadow:
            button.float()
        case .none:
            break
        }
        
        button.frame = CGRect(x: 0, y: 0, width: frameWidth, height: frameHeight)
        
        return button
    }
    
    func disable(animated: Bool = true) {
        let duration: TimeInterval = animated ? 0.3 : 0
        UIView.animate(withDuration: duration) {
            self.isEnabled = false
            self.alpha = 0.3
        }
    }
    
    func enable(animated: Bool = true) {
        let duration: TimeInterval = animated ? 0.3 : 0
        UIView.animate(withDuration: duration) {
            self.isEnabled = true
            self.alpha = 1.0
        }
    }
}
