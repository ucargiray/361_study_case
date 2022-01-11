//
//  NetworkError.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation

enum NetworkError : Error {
    case badURL
    case generalError
    case decodingError
}
