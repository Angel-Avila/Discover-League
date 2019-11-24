//
//  SectionFooter.swift
//  Discover League
//
//  Created by Angel Avila on 24/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

class SectionFooter: UICollectionReusableView, SelfConfiguringSection {
    static let reuseIdentifier = "SectionFooter"
    
    private let title = UILabel()
    private let subtitle = UILabel()
    private let topSeparator = SectionFooter.createSeparator()
    
    typealias QuickLink = (text: String, link: String)
    
    private let quickLinks: [QuickLink] = [
        (text: "Homepage", link: "https://play.na.leagueoflegends.com/en_US"),
        (text: "Universe", link: "https://universe.leagueoflegends.com/en_US/"),
        (text: "YouTube Channel", link: "https://www.youtube.com/user/RiotGamesInc/featured"),
        (text: "Facebook Page", link: "https://www.facebook.com/leagueoflegends")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        title.textColor = .label
        title.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        subtitle.textColor = .secondaryLabel
        subtitle.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: createArrangedSubviews())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        stackView.setCustomSpacing(10, after: topSeparator)
        stackView.setCustomSpacing(20, after: subtitle)
    }
    
    private func buttonsForQuickLinks() -> [UIButton] {
        var buttons = [UIButton]()
        
        for (i, quickLink) in quickLinks.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(quickLink.text, for: .normal)
            button.setTitleColor(.systemOrange, for: .normal)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
            button.tag = i
            button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            button.contentHorizontalAlignment = .leading
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            buttons.append(button)
        }
        
        return buttons
    }
    
    @objc private func buttonPressed(sender: UIButton) {
        let link = quickLinks[sender.tag].link
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    private func createArrangedSubviews() -> [UIView] {
        let buttons = buttonsForQuickLinks()
        
        var views: [UIView] = [topSeparator, title, subtitle]
        
        for(i, button) in buttons.enumerated() {
            views.append(button)
            if i != buttons.count - 1 {
                views.append(SectionFooter.createSeparator())
            }
        }
        
        return views
    }
    
    private static func createSeparator() -> UIView {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
    
    func configure(with section: ChampionSection) {
        title.text = "Quick Links"
        subtitle.text = "Riot's official links for everything League of Legends!"
    }
    
    required init?(coder: NSCoder) {
        fatalError("stop please")
    }
}
