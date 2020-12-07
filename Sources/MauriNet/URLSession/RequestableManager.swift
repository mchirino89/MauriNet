//
//  RequestableManager.swift
//  
//
//  Created by Mauricio Chirino on 07/12/20.
//

import Foundation

public typealias NetworkResult = (Result<Data, NetworkError>) -> Void
public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

extension URLSession: URLSessionable {
    public func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask {
        dataTask(with: request.url!, completionHandler: completion)
    }
}

public protocol URLSessionable {
    func dataTaskWithURL(_ request: URLRequest, completion: @escaping DataTaskResult) -> URLSessionDataTask
}

public protocol RequestableManager {
    func request(_ request: URLRequest, completion: @escaping NetworkResult)
}
