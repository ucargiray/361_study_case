//
//  VideoPlayerViewModel.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation


class VideoPlayerViewModel {

    var selectedVideo: Video?

    init(selectedVideo: Video) {
        self.selectedVideo = selectedVideo
    }
    
    func getFileURL() -> URL {
        if let unwrappedURLString = selectedVideo?.sources?[0] , let fileURL = URL(string: unwrappedURLString){
            return fileURL
        }
        else {
            return URL(string: "")!
        }
    }
}
