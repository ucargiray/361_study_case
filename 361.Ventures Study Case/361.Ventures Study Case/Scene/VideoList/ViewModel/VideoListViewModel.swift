//
//  VideoListViewModel.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation
import Combine


class VideoListViewModel {

    typealias dataType = [VideoResponse]

    private(set) var dataManager: NetworkManager<dataType>

    init(dataManager: NetworkManager<dataType>) {
        self.dataManager = dataManager
    }

    @Published private(set) var videos = [Video]()
    @Published private(set) var shouldUpdateUI = false
    @Published private(set) var errorMessage : String?

    func getVideos() {
        dataManager.makeTheRequest(using: URLStringConstants.shared.videoListURLString) { result in
            switch result {
            case .success(let response):
                self.videos = response[0].videos
                self.shouldUpdateUI.toggle()
            case .failure(let error):
                let error = error as? NetworkError
                switch error {
                case .badURL:
                    self.errorMessage = "Bad URL"
                case .decodingError:
                    self.errorMessage = "Data could not be decoded"
                case .generalError:
                    self.errorMessage = "There was a problem"
                case .none:
                    self.errorMessage = nil
                case .some(let error):
                    self.errorMessage = "\(error.localizedDescription)"
                }
                self.shouldUpdateUI.toggle()
            }
        }
    }
}
