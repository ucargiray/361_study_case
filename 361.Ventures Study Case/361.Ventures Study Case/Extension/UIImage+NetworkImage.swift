//
//  UIImage+NetworkImage.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import UIKit

extension UIImageView {
    
    func networkImage(from url: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: url) else { return }
        contentMode = mode
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
