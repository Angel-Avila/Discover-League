//
//  Champion.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import Foundation

extension CodingUserInfoKey {
    static let rootKeyName = CodingUserInfoKey(rawValue: "rootKeyName")!
    static let secondaryContainer = CodingUserInfoKey(rawValue: "secondaryContainer")! // ChampionId
}

struct Champion: Decodable, Hashable {
    let id: String
    let name: String
    let title: String
    let skins: [Skin]
    let lore: String
    let roles: [String] // tags
    let passive: Passive
    let spells: [Spell]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case title = "title"
        case skins = "skins"
        case lore = "lore"
        case roles = "tags"
        case passive = "passive"
        case spells = "spells"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.title = try container.decode(String.self, forKey: .title)
        self.skins = try container.decode([Skin].self, forKey: .skins)
        self.lore = try container.decode(String.self, forKey: .lore)
        self.roles = try container.decode([String].self, forKey: .roles)
        self.passive = try container.decode(Passive.self, forKey: .passive)
        self.spells = try container.decode([Spell].self, forKey: .spells)
    }
    
    var defaultSkin: Skin? {
        skins.filter { $0.name == "default" }.first
    }
    
    var tileImage: UIImage? {
        defaultSkin?.tileImage
    }
    
    var loadingImage: UIImage? {
        defaultSkin?.loadingImage
    }
    
    var splashImage: UIImage? {
        defaultSkin?.splashImage
    }
}

struct Skin: Decodable, Hashable {
    let id: String
    let name: String
    private let imageName: String // [Champion id]_(id % 100).jpg - path: img/champion
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        guard let intId = Int(id),
            let championId = decoder.userInfo[.secondaryContainer] as? String else {
                fatalError("Skin id not valid")
        }
        
        let imageId = intId % 100
        let championName = championId == "Fiddlesticks" ? "FiddleSticks" : championId // RIOT FIX UR GAME
        self.imageName = "\(championName)_\(imageId)"
    }
    
    var loadingImage: UIImage? {
        get {
            UIImage(named: "loading/\(imageName)")
        }
    }
    
    var splashImage: UIImage? {
        get {
            UIImage(named: "splash/\(imageName)")
        }
    }
    
    var tileImage: UIImage? {
        get {
            UIImage(named: "tiles/\(imageName)")
        }
    }
}

struct Spell: Decodable, Hashable {
    let id: String
    let name: String
    let description: String
    private let imageName: String // [Spell id].png - path: 9.22/img/spell

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageName = id
    }
    
    var image: UIImage? {
        get {
            UIImage(named: imageName)
        }
    }
}

struct Passive: Decodable, Hashable {
    let name: String
    let description: String
    private let imageName: String // passive.image.full - path: 9.22/img/passive
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case imageContainer = "image"
        case imageName = "full"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        let imageContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageContainer)
        self.imageName = try imageContainer.decode(String.self, forKey: .imageName)
    }
    
    var image: UIImage? {
        get {
            UIImage(named: imageName)
        }
    }
}


extension Bundle {
    func decodeChampions(localization: String) -> [Champion] {
        guard let urls = self.urls(forResourcesWithExtension: "json", subdirectory: "", localization: localization) else {
            fatalError("Failed to locate json files in bundle.")
        }
        
        let filteredUrls = urls.filter { $0.lastPathComponent.components(separatedBy: ".").first! != "sections" }
        
        return filteredUrls.map { url in
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Failed to load file at \(url.absoluteString) from bundle.")
            }

            let decoder = JSONDecoder()
            
            let championName = url.lastPathComponent.components(separatedBy: ".").first!
            
            guard let loaded = try? decoder.decode(Champion.self, from: data, keyedBy: "data", secondaryKey: championName) else {
                fatalError("Failed to decode \(championName) with localization \(localization) from bundle.")
            }
            
            return loaded
        }
    }
    
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyedBy key: String?, secondaryKey: String?) throws -> T {
        if let key = key {
            userInfo[.rootKeyName] = key
            
            if let secondaryKey = secondaryKey {
                userInfo[.secondaryContainer] = secondaryKey
            }
            
            let root = try decode(DecodableRoot<T>.self, from: data)
            return root.value
        } else {
            return try decode(type, from: data)
        }
    }
}


struct DecodableRoot<T>: Decodable where T: Decodable {
    private struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }
        static func key(named name: String) -> CodingKeys? {
            return CodingKeys(stringValue: name)
        }
    }
    
    let value: T
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard
            let keyName = decoder.userInfo[.rootKeyName] as? String,
            let key = CodingKeys.key(named: keyName) else {
                throw DecodingError.valueNotFound(
                    T.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Value not found at root level.")
                )
        }
        
        guard
            let championName = decoder.userInfo[.secondaryContainer] as? String,
            let championKey = CodingKeys.key(named: championName) else {
                throw DecodingError.valueNotFound(T.self, DecodingError.Context(codingPath: [], debugDescription: "Champion name not found."))
        }
        
        let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: key)
        
        value = try nestedContainer.decode(T.self, forKey: championKey)
    }
}
