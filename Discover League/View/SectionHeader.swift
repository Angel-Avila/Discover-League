//
//  SectionHeader.swift
//  Discover League
//
//  Created by Angel Avila on 21/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class SectionHeader: UICollectionReusableView, SelfConfiguringSection {
    static let reuseIdentifier = "SectionHeader"
    
    let title = UILabel()
    let subtitle = UILabel()
    
    let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        subtitle.textColor = .secondaryLabel
        
        button.setTitleColor(.systemOrange, for: .normal)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17))
        
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let textStackView = UIStackView(arrangedSubviews: [title, subtitle])
        textStackView.axis = .vertical
        
        let horizontalStackView = UIStackView(arrangedSubviews: [textStackView, button])
        horizontalStackView.axis = .horizontal
        
        let outerStackView = UIStackView(arrangedSubviews: [separator, horizontalStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .vertical
        addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            outerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        outerStackView.setCustomSpacing(10, after: separator)
    }
    
    func configure(with section: ChampionSection) {
        title.text = section.title
        subtitle.text = section.subtitle
        if section.showsButton {
            showButton()
        } else {
            hideButton()
        }
    }
    
    func showButton() {
        button.alpha = 1
    }
    
    func hideButton() {
        button.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("stop please")
    }
}
