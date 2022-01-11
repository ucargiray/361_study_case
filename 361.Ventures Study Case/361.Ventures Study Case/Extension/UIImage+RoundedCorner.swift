//
//  UIImage+RoundedCorner.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import UIKit

extension UIImageView {
    func createRoundedCorner(by radius : CGFloat) {
        self.layer.cornerRadius = radius
    }
}
