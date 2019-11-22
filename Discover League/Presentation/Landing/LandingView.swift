//
//  LandingView.swift
//  Discover League
//
//  Created by Angel Avila on 16/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class LandingView: DLView {
    
    lazy private var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "splash2"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy private var backgroundCover: UIView = {
        let cover = UIView()
        cover.backgroundColor = .black
        cover.alpha = 0
        return cover
    }()
    
    lazy private var logoView: UIView = {
        let logoView = UIView()
        logoView.backgroundColor = .white
        let size: CGFloat = 100
        logoView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        logoView.layer.cornerRadius = size / 2
        logoView.alpha = 0
        return logoView
    }()
    
    private let logoSize: CGFloat = 48
    private let logoTargetY: CGFloat = 150
    
    lazy private var logoImage: UIImageView = {
        let imageView = UIImageView(image: Icon.smallLogo.image?.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.frame = CGRect(x: 0, y: 0, width: logoSize, height: logoSize)
        imageView.alpha = 0
        return imageView
    }()
    
    lazy private var innerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        let size: CGFloat = 180
        view.frame = CGRect(x: 0, y: 0, width: size, height: size)
        view.layer.cornerRadius = size / 2
        view.alpha = 0
        return view
    }()
    
    lazy private var outerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.alpha = 0
        let size: CGFloat = 300
        view.frame = CGRect(x: 0, y: 0, width: size, height: size)
        view.layer.cornerRadius = size / 2
        return view
    }()
    
    lazy private var formView = LandingFormView()
    
    var languageCode: String? {
        get {
            formView.languageCode
        }
    }
    
    override init() {
        super.init()
        addSubviews([backgroundImage, backgroundCover, logoView, logoImage, innerCircleView, outerCircleView, formView])
        formView.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    func addEnterButtonTarget(target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        formView.addEnterButtonTarget(target: target, action: action, for: controlEvent)
    }
    
    override func setupUI() {
        backgroundImage.pin.all()
        
        backgroundCover.pin.all()

        [logoView, logoImage, innerCircleView, outerCircleView].forEach { $0.pin.center() }
        
        formView.pin
            .hCenter()
            .top(logoTargetY + logoSize + 30)
            .width(UIScreen.main.bounds.width - 60)
            .height(200)
        
    }
    
    func animateAppearance() {
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveLinear, animations: {
            self.backgroundCover.alpha = 0.75
            self.innerCircleView.alpha = 1
            self.outerCircleView.alpha = 0.5
            self.logoView.alpha = 1
            self.logoImage.alpha = 1
        }) { _ in
            self.animateLogoTranslation()
        }
    }
    
    private func animateLogoTranslation() {
        let yTranslation = self.logoImage.center.y - logoTargetY - (self.logoSize / 2)
        
        UIView.animate(withDuration: 0.4, delay: 0.3, options: .curveEaseIn, animations: {
            self.logoImage.tintColor = .white
            self.innerCircleView.alpha = 0
            self.outerCircleView.alpha = 0
            self.logoView.alpha = 0
            self.logoImage.transform = CGAffineTransform(translationX: 0, y: -yTranslation)
        }) { _ in
            self.animateFormAppearing()
        }
    }
    
    private func animateFormAppearing() {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: {
            self.formView.alpha = 1
        })
    }
}
