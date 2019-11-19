//
//  Settings.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import LeagueAPI

class Settings {
    
    private let db: UserDefaults
    
    init(db: UserDefaults = .standard) {
        self.db = db
    }
    
    private enum DatabaseKey: String {
        case summonerName = "DL_summonerName"
        case region = "DL_region"
        case preferredLanguage = "DL_preferredLanguage"
    }
    
    var summonerName: String? {
        get {
            db.string(forKey: DatabaseKey.summonerName.rawValue)
        }
        set {
            guard let name = newValue else { return }
            db.set(name, forKey: DatabaseKey.summonerName.rawValue)
        }
    }
    
    var region: Region? {
        get {
            db.value(forKey: DatabaseKey.region.rawValue) as? Region
        }
        set {
            guard let region = newValue else { return }
            db.set(region, forKey: DatabaseKey.region.rawValue)
        }
    }
    
    var preferredLanguage: String? {
        get {
            db.string(forKey: DatabaseKey.preferredLanguage.rawValue)
        }
        set {
            db.set(newValue, forKey: DatabaseKey.preferredLanguage.rawValue)
        }
    }
}
