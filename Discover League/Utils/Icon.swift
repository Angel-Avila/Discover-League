//
//  Icon.swift
//  Foodie
//
//  Created by Angel Avila on 10/15/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

enum Icon {
    case smallLogo
}

extension Icon {
    
    var image: UIImage? {
        switch self {
        case . smallLogo:
            return UIImage(named: "logo-black")
        }
    }
}
