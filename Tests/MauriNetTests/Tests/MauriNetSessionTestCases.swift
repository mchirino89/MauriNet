//
//  MauriNetSessionTestCases.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import XCTest
@testable import MauriNet

final class MauriNetSessionTestCases: XCTestCase {
    var mockRequestManager: RequestManager!
    var dummyURLRequest: URLRequest!
    var mockSession: URLSessionable!

    override func tearDown() {
        super.tearDown()
        mockRequestManager = nil
        dummyURLRequest = nil
        mockSession = nil
    }

    func testRequestManagerErrorConsumptionHandling() {
        // Given
        let requestExpectation = expectation(description: "requestExpectation")
        givenCorruptedManager()

        // When
        mockRequestManager.request(dummyURLRequest) { result in
            switch result {
            case .success:
                XCTFail("A failing response shouldn't produce a successful status code")
                requestExpectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.malformedRequest)
                requestExpectation.fulfill()
            }
        }

        // Then
        wait(for: [requestExpectation], timeout: 0.1)
    }

    func testRequestManagerSuccessConsumptionHandling() {
        // Given
        let requestExpectation = expectation(description: "requestExpectation")
        givenProperSetManager()

        // When
        mockRequestManager.request(dummyURLRequest) { result in
            switch result {
            case .success(let data):
                XCTAssertNotEqual(data.count, 0)
                requestExpectation.fulfill()
            case .failure(let error):
                XCTFail("Failed due to: \(error.localizedDescription)")
                requestExpectation.fulfill()
            }
        }

        // Then
        wait(for: [requestExpectation], timeout: 0.1)
    }
}

private extension MauriNetSessionTestCases {
    func givenCorruptedManager() {
        mockSession = URLFailingSessionMock()
        mockRequestManager = RequestManager(session: mockSession)
        dummyURLRequest = URLRequest(url: URL(validURL: "loremIpsum"))
    }

    func givenProperSetManager() {
        mockSession = URLSuccessSessionMock()
        mockRequestManager = RequestManager(session: mockSession)
        dummyURLRequest = URLRequest(url: URL(validURL: "loremIpsum"))
    }
}
