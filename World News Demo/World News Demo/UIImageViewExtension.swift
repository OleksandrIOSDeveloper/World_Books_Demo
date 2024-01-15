//
//  UIImageViewExtension.swift
//  World News Demo
//
//  Created by Александр Родителев on 21.11.2023.
//

import UIKit

extension UIImageView {

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
}

