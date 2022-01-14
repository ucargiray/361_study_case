//
//  RemoteStorageManager.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation

final class NetworkManager<T : Codable>: NetworkManagerProtocol {

    typealias dataType = T

    func makeTheRequest(using url: String, completionHandler: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(NetworkError.badURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler(.failure(NetworkError.generalError))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completionHandler(.success(decodedData))
                } catch {
                    completionHandler(.failure(NetworkError.decodingError))
                }
            }
        }.resume()
    }

}
