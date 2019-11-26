//
//  ComponentProvider.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

/// An enum that represents where the app should go or which ViewController it should show.
enum NavigationView {
    /// Root view controller of the app
    case root
        
    /// Screen where user enters their summoner name
    case landing
    
    case home
    
    /// No view controller. Could be used in some cases where navigation shouldn't go there.
    case none
}

class DefaultComponentProvider: ComponentProvider {
    
    let db = UserDefaults.standard
    
    /// Returns a `UIViewController` depending on which `NavigationView` enum case you sent.
    ///
    /// - Parameter view: A case from the `NavigationView` enum. It represents a view controller and every new view controller the code should navigate to, should be added to be handled here.
    /// - Returns: The ViewController to be presented/navigated to.
    func resolve(_ view: NavigationView) -> UIViewController {
        switch view {
            
        case .root:
            return getRoot()
            
        case .landing:
            return LandingViewController()
            
        case .home:
            return HomeViewController()
            
        default:
            return UIViewController(nibName: nil, bundle: nil)
        }
    }
    
    private func getRoot() -> UIViewController {
        if db.bool(forKey: DBKey.onboardingComplete.rawValue) {
            return resolve(.home)
        }
        return resolve(.landing)
    }
}
