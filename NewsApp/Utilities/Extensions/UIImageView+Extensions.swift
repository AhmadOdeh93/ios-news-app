//
//  UIImageView+Extensions.swift
//  NewsApp
//
//  Created by Ahmad Odeh on 27/07/2025.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder ?? UIImage(systemName: "photo")
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else { return }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
