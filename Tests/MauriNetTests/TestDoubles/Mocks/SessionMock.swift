//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation

/// URL session for partial mocking implementation during testing.
/// [Source](https://www.swiftbysundell.com/articles/mocking-in-swift/)
final class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var data: Data?
    var error: Error?

    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
