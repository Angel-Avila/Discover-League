//
//  SelfConfiguringSection.swift
//  Discover League
//
//  Created by Angel Avila on 24/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

protocol SelfConfiguringSection {
    static var reuseIdentifier: String { get }
    func configure(with section: ChampionSection)
}
