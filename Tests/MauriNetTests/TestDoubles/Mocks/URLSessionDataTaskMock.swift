//
//  URLSessionDataTaskMock.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    /// Fulfills the provided closure immediately 
    override func resume() {
        closure()
    }
}
