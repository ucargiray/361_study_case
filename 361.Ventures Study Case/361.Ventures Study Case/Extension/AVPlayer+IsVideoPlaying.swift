//
//  UIView+Nib.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 10.01.2022.
//

import AVKit

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
