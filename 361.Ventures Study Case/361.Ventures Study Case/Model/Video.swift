//
//  Video.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation

struct VideoResponse: Codable {
    let name: String
    let videos: [Video]
}

struct Video: Codable {
    let description: String?
    let sources: [String]?
    let subtitle: String?
    let thumb: String?
    let title: String?

}
