//
//  String+.swift
//  Discover League
//
//  Created by Angel Avila on 16/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        let userLang = Locale.current.languageCode
        let bundlePath = Bundle.main.path(forResource: userLang, ofType: "lproj")
        let bundle = Bundle(path: bundlePath ?? "") ?? Bundle.main
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
