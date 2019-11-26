//
//  LandingView.swift
//  Discover League
//
//  Created by Angel Avila on 16/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import PinLayout

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
    
    lazy private var container: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 8
        view.float()
        view.alpha = 0
        return view
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Welcome to\nDiscover League!"
        return label
    }()
    
    private var disclaimer: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.textColor = .secondaryLabel
        textView.backgroundColor = .tertiarySystemBackground
        textView.layer.cornerRadius = 8
        textView.isEditable = false
        textView.text = "This app was made to discover more of League of Legend's great champions, what they do and their artwork.\n" +
            "It uses offline resources provided by Riot games so you don't have to woorry about your data plan.\n\n" +
            "DISCLAIMER: Discoover League isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc."
        return textView
    }()
    
    lazy private var enterButton = UIButton.colorButton(color: .systemOrange, height: 50, font: .bold, textColor: .white, localizableTitle: "enter", buttonType: .rounded, shadowType: .defaultShadow)
    
    override init() {
        super.init()
        container.addSubview(title)
        container.addSubview(disclaimer)
        container.addSubview(enterButton)
        addSubviews([backgroundImage, backgroundCover, logoView, logoImage, innerCircleView, outerCircleView, container])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    func addEnterButtonTarget(target: Any?, action: Selector, for controlEvent: UIControl.Event) {
        enterButton.addTarget(target, action: action, for: controlEvent)
    }
    
    override func setupUI() {
        backgroundImage.pin.all()
        
        backgroundCover.pin.all()

        [logoView, logoImage, innerCircleView, outerCircleView].forEach { $0.pin.center() }
        
        container.pin
            .hCenter()
            .top(logoTargetY + logoSize + 30)
            .width(UIScreen.main.bounds.width - 60)
            .height(66%)
        
        title.pin.top(20)
            .horizontally(20)
            .sizeToFit(.width)
        
        enterButton.pin.bottom(20)
            .hCenter()
            .size(.init(width: 140, height: 50))
        
        disclaimer.pin.verticallyBetween(title, and: enterButton)
            .horizontally(20)
            .marginVertical(20)
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
            self.container.alpha = 1
        })
    }
}
