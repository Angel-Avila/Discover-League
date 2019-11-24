//
//  TallCell.swift
//  Discover League
//
//  Created by Angel Avila on 21/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

final class TallCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseIdentifier: String = "TallCell"
    static let height: CGFloat = 320
    
    let name = UILabel()
    let title = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .footnote)
        name.textColor = .label
        
        title.font = UIFont.preferredFont(forTextStyle: .footnote)
        title.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.separator.cgColor
        imageView.layer.borderWidth = 1
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
//        title.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let stackView = UIStackView(arrangedSubviews: [imageView])
        stackView.axis = .horizontal
        
        let outerStackView = UIStackView(arrangedSubviews: [stackView, name, title])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.axis = .vertical
        outerStackView.alignment = .leading
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.heightAnchor.constraint(equalToConstant: TallCell.height)
        ])
        
        outerStackView.setCustomSpacing(6, after: stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("just...no")
    }
    
    func configure(with champion: Champion) {
        name.text = champion.name
        title.text = champion.title.capitalized
    }
    
    func configure(with skin: Skin) {
        imageView.image = skin.loadingImage
    }
}
