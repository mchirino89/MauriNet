//
//  NetworkErrorTestCase.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import XCTest
@testable import MauriNet

final class NetworkErrorTestCase: XCTestCase {
    func testErrorCodeMatching() {
        NetworkError.allCases.forEach {
            let builtError = NetworkError.buildError(from: $0.rawValue)
            XCTAssertEqual(builtError.rawValue, $0.errorCode)
            XCTAssertFalse(builtError.localizedDescription.isEmpty)
        }
    }

    func testGeneratedErrorForUnknownCodes() {
        // Given
        let unknownCode = 12345

        // When
        let generatedError = NetworkError.buildError(from: unknownCode)

        // Then
        XCTAssertEqual(NetworkError.unknown, generatedError)
    }
}
