//
//  Section.swift
//  Discover League
//
//  Created by Angel Avila on 21/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

struct ChampionSection: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let showsButton: Bool
    let subtitle: String
    let dataIdentifiers: [DataIdentifier]
}

struct DataIdentifier: Decodable, Hashable {
    let championId: String
    let skinId: String
}
