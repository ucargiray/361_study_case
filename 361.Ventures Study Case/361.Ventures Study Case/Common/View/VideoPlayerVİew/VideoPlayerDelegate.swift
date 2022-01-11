//
//  VideoPlayerDelegate.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 7.01.2022.
//

import Foundation

// USE DELEGATES TO CHANGE YOUR UI.
/*
    Look at Scene -> VideoPlayer -> View -> VideoPlayer+VideoPlayerDelegate.swift file for an example usage.
 */

protocol VideoPlayerDelegate : AnyObject {
    func didFailedToLoad()
    func shouldPauseTheVideo()
    func shouldStartTheVideo()
    func shouldDestoryVideo()
}
