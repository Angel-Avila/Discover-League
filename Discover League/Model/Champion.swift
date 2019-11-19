//
//  Champion.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    static let rootKeyName = CodingUserInfoKey(rawValue: "rootKeyName")! // ChampionId
}

struct Champion: Decodable {
    let id: String
    let name: String
    let title: String
    let skins: [Skin]
    let lore: String
    let roles: [String] // tags
    let passive: Passive
    let spells: [Spell]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case id = "id"
        case name = "name"
        case title = "title"
        case skins = "skins"
        case lore = "lore"
        case roles = "tags"
        case passive = "passive"
        case spells = "spells"
        
        static func key(named name: String) -> CodingKeys? {
            return CodingKeys(stringValue: name)
        }
    }
    
    init(from decoder: Decoder) throws {
        guard
            let rootKeyName = decoder.userInfo[.rootKeyName] as? String,
            let rootKey = CodingKeys.key(named: rootKeyName) else {
                fatalError("Root key not set. This should be the champion id and should be set in the decoder user info dictionary")
        }
        
        let upperContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        let championContainer = try upperContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        let container = try championContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: rootKey)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.title = try container.decode(String.self, forKey: .title)
        self.skins = try container.decode([Skin].self, forKey: .skins)
        self.lore = try container.decode(String.self, forKey: .lore)
        self.roles = try container.decode([String].self, forKey: .roles)
        self.passive = try container.decode(Passive.self, forKey: .passive)
        self.spells = try container.decode([Spell].self, forKey: .spells)
    }
}

struct Skin: Decodable {
    let id: String
    //let imageName: String // [Champion id]_(id % 100).jpg - path: img/champion
    let name: String
    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//    }
}

struct Spell: Decodable {
    let name: String
    let description: String
    //let imageName: String // [Spell id].png - path: 9.22/img/spell
}

struct Passive: Decodable {
    let name: String
    let description: String
    //let imageName: String // passive.image.full - path: 9.22/img/passive
}
