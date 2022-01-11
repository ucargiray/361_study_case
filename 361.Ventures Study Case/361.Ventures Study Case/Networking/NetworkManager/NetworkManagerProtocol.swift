//
//  RemoteStorageProtocol.swift
//  361.Ventures Study Case
//
//  Created by Giray UÇAR on 6.01.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    associatedtype dataType
    
    func makeTheRequest(using url : String , completionHandler : @escaping ((Result<dataType,Error>) -> Void))
}
