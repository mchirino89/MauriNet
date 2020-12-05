//
//  URLFailingSessionMock.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation
@testable import MauriNet

/// URL session mocking implementation during testing.
/// [Source](https://masilotti.com/testing-nsurlsession-input/)
struct URLFailingSessionMock: URLSessionable {
    func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completion(nil, nil, nil)
        }
    }
}

struct URLSuccessSessionMock: URLSessionable {
    func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            let dummyData = "dummyData".data(using: .utf8)!
            let response = HTTPURLResponse(url: request.url!,
                                           mimeType: nil,
                                           expectedContentLength: 10,
                                           textEncodingName: nil)

            completion(dummyData, response, nil)
        }
    }
}
