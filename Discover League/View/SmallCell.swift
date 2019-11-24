//
//  SmallCell.swift
//  Discover League
//
//  Created by Angel Avila on 24/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class SmallCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "SmallCell"
    
    private let name = UILabel()
    private let imageView = UIImageView()
    private let separator = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        name.textColor = .label
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        let stackView = UIStackView(arrangedSubviews: [imageView, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 38),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 58),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with champion: Champion) {
        let role = champion.roles.first!
        name.text = role
        imageView.image = UIImage(named: role)
    }
    
    func configure(with skin: Skin) {
        
    }
    
    func showSeparator() {
        separator.alpha = 1
    }
    
    func hideSeparator() {
        separator.alpha = 0
    }

    required init?(coder: NSCoder) {
        fatalError("*sigh*")
    }
}
