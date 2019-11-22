//
//  SelfConfiguringCell.swift
//  Discover League
//
//  Created by Angel Avila on 21/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with champion: Champion)
    func configure(with skin: Skin)
}
