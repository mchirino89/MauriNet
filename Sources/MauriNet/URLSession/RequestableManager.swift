//
//  RequestableManager.swift
//  
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

/// Custom `Result` object for type of networking result
public typealias NetworkResult = (Result<Data, NetworkError>) -> Void

/// Wrapper for encapsulating Foundation native response values from Data task
public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

extension URLSession: URLSessionable {
    public func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask {
        dataTask(with: request.url!, completionHandler: completion)
    }
}

/// Network session type
public protocol URLSessionable {
    func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask
}

/// Network manager type
public protocol RequestableManager {
    /// Triggers a generic request in an asynchronous matter
    /// - Parameters:
    ///   - request: URL request specifications
    ///   - completion: Resulting completion closure from request
    func request(_ request: URLRequest, completion: @escaping NetworkResult)
}
