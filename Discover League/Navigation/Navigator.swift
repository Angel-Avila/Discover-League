//
//  Navigator.swift
//  Discover League
//
//  Created by Angel Avila on 18/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

/// Declares what type of navigation to do whenever you call the `navigate` function from the `Navigator` class.
enum NavigationTarget {
    /// Sets root of the Navigator's navigation controller.
    case setRoot(view: NavigationView)
    
    /// Calls the `.dismiss` method on the source view controller.
    case dismiss
    
    /// Calls the `pushViewController` method on the navigation controller.
    case push(view: NavigationView)
    
    /// Calls the `present` method on the source view controller.
    case present(view: NavigationView)
    
    /// Calls the `present` method on the source view controller. It presents the resolved `NavigationView` as the root of a new `NavigationController`.
    case presentOnNavigationController(view: NavigationView)
    
    /// Calls the `.pop` method on the navigation controller.
    case pop
    
    /// Calls the `.popToRoot` method on the navigation controller.
    case popToRoot
}

protocol ComponentProvider {
    func resolve(_ view: NavigationView) -> UIViewController
}

class Navigator {
    
    var provider: ComponentProvider!
    var navigationController: UINavigationController!
    
    init(provider: ComponentProvider) {
        self.provider = provider
        setupNavigationController()
    }
    
    func getRoot() -> UIViewController {
        return navigationController
    }
    
    /// Navigate to the specified view as specified.
    ///
    /// - Parameters:
    ///   - target: what to do with the navigation. If presenting a new view controller, a `NavigationView` enum object is sent.
    ///   - source: from where the View Controller should be presented. The source usually is `self`.
    ///   - animated: whether the presentation should be animated or not. Default is `true`.
    func navigate(_ target: NavigationTarget, _ source: UIViewController, animated: Bool = true) {
        switch target {
            
        case .dismiss:
            source.dismiss(animated: animated, completion: nil)
            
        case .pop:
            source.navigationController?.popViewController(animated: animated)
            
        case .popToRoot:
            source.navigationController?.popToRootViewController(animated: animated)
            
        case .push(let view):
            let vc = provider.resolve(view)
            source.navigationController?.pushViewController(vc, animated: animated)
            
        case .present(let view):
            let vc = provider.resolve(view)
            source.present(vc, animated: animated, completion: nil)
            
        case .presentOnNavigationController(let view):
            let vc = provider.resolve(view)
            let nc = UINavigationController(rootViewController: vc)
            
            source.present(nc, animated: animated, completion: nil)

        case .setRoot(let view):
            let vc = provider.resolve(view)
            source.navigationController?.setViewControllers([vc], animated: animated)
        }
    }
    
    func setBackButtonItemTitle(to title: String) {
        let backButton = UIBarButtonItem()
        backButton.title = title
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setNavigationControllerRoot(_ view: NavigationView, animated: Bool = true) {
        navigationController.setViewControllers([provider.resolve(view)], animated: animated)
    }
    
    private func setupNavigationController() {
        navigationController = UINavigationController(rootViewController: provider.resolve(.root))
        navigationController.isNavigationBarHidden = true
    }
}

extension UIViewController {
    func getNavigator() -> Navigator? {
        return (self.view.window?.windowScene?.delegate as? SceneDelegate)?.navigator
    }
}
