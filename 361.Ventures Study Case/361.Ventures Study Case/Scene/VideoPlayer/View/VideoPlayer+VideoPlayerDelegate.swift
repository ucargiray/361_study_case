//
//  VideoPlayer+VideoPlayerDelegate.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 7.01.2022.
//

import UIKit

extension VideoPlayerViewController: VideoPlayerDelegate {

    func shouldPauseTheVideo() {
        videoPlayerView.player?.pause()
    }

    func shouldStartTheVideo() {
        destroyLoadingIndicator()
        videoPlayerView.player?.play()
    }

    func didFailedToLoad() {
        destroyLoadingIndicator()
        let alertController = UIAlertController(title: "Unable to load video", message: "Network connection may be lost.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func shouldDestoryVideo() {
        destroyLoadingIndicator()
    }
}
