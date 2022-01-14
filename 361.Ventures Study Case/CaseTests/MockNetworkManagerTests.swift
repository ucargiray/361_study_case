//
//  CaseTests.swift
//  CaseTests
//
//  Created by Giray UÇAR on 14.01.2022.
//

import XCTest
@testable import _61_Ventures_Study_Case

final class MockNetworkManager: NetworkManagerProtocol {
    func makeTheRequest(using url: String, completionHandler: @escaping ((Result<String, Error>) -> Void)) {
        completionHandler(.success("Done"))
    }
    typealias dataType = String
}

class MockNetworkManagerTests: XCTestCase {
    func test_mock_network_manager_if_returns_expected_value() {
        let sut = MockNetworkManager()
        var resultFromMockNetworkManager = ""
        sut.makeTheRequest(using: "") { val in
            switch val {
            case .success(let result):
                resultFromMockNetworkManager = result
            case .failure(let error):
                resultFromMockNetworkManager = error.localizedDescription
            }
        }
        XCTAssertTrue(resultFromMockNetworkManager == "Done")
    }
    
    func test_mock_network_manager_if_returns_wrong_value() {
        let sut = MockNetworkManager()
        var resultFromMockNetworkManager = ""
        sut.makeTheRequest(using: "") { val in
            switch val {
            case .success(let result):
                resultFromMockNetworkManager = result
            case .failure(let error):
                resultFromMockNetworkManager = error.localizedDescription
            }
        }
        XCTAssertTrue(resultFromMockNetworkManager == "De")
    }

}
