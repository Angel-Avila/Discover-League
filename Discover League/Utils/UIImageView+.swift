//
//  UIImageView+.swift
//  Foodie
//
//  Created by Angel Avila on 10/16/19.
//  Copyright © 2019 Angel Avila. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self?.image = image
            }
        }.resume()
    }
    
    func setImage(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        setImage(from: url, contentMode: mode)
    }
}
