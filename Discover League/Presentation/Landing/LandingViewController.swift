//
//  LandingViewController.swift
//  Discover League
//
//  Created by Angel Avila on 14/11/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit
import LeagueAPI
import SwiftUI

class LandingViewController: ViewController<LandingView> {

    private let settings: Settings
    
    init(settings: Settings) {
        self.settings = settings
        
        super.init()
        controllerView = LandingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerView.animateAppearance()
        controllerView.addEnterButtonTarget(target: self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
    @objc private func enterButtonPressed() {

    }
}


struct LandingPreview: PreviewProvider {
    static var previews: some View {
        PreviewView().edgesIgnoringSafeArea(.all)
    }
    
    struct PreviewView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<LandingPreview.PreviewView>) -> UIViewController {
            return LandingViewController(settings: Settings())
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LandingPreview.PreviewView>) {
        }
    }
}
