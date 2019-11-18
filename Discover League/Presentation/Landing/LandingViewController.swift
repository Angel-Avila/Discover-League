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

    private var imageView = UIImageView(image: UIImage(named: "splash2"))
    
    init() {
        super.init()
        controllerView = LandingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerView.animateAppearance()
    }
    
    @objc private func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


struct LandingPreview: PreviewProvider {
    static var previews: some View {
        PreviewView().edgesIgnoringSafeArea(.all)
    }
    
    struct PreviewView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<LandingPreview.PreviewView>) -> UIViewController {
            return LandingViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LandingPreview.PreviewView>) {
        }
    }
}
