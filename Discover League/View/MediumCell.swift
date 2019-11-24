//
//  MediumCell.swift
//  Discover League
//
//  Created by Angel Avila on 23/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class MediumCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "MediumCell"
    
    private let name = UILabel()
    private let subtitle = UILabel()
    private let imageView = UIImageView()
    private let readOnlineButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 3
        
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.layer.borderWidth = 1
        
        readOnlineButton.setImage(UIImage(systemName: "safari"), for: .normal)
        readOnlineButton.tintColor = .systemOrange
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        readOnlineButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical
        innerStackView.alignment = .top
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, readOnlineButton])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with champion: Champion) {
        name.text = champion.name
        subtitle.text = champion.lore
    }
    
    func configure(with skin: Skin) {
        imageView.image = skin.tileImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("no")
    }
}
