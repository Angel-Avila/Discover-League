//
//  DLClient.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import LeagueAPI

struct RequestError: Error {
    let message: String
}

class DLClient {
    
    private let api: LeagueAPI!
    
    private struct AuthorizationPlist: Codable {
        let token: String
    }
    
    private var token: String = {
        let path = Bundle.main.path(forResource: "Authorization", ofType: "plist")
        let xml = FileManager.default.contents(atPath: path ?? "")
        let plist = try? PropertyListDecoder().decode(AuthorizationPlist.self, from: xml ?? Data())
        return plist?.token ?? ""
    }()
    
    init() {
        api = LeagueAPI(APIToken: self.token)
    }
    
    func getSummoner(name: String, region: Region, completion: @escaping (Result<Summoner, RequestError>) -> Void) {
        api.riotAPI.getSummoner(byName: name, on: region) { (summoner, errorMessage) in
            if let summoner = summoner {
                completion(.success(summoner))
            } else {
                let error = RequestError(message: errorMessage ?? "")
                completion(.failure(error))
            }
        }
    }
}
