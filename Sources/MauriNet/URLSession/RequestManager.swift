//
//  RequestManager.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

/// Wrapper object that handles network session
public struct RequestManager: RequestableManager {
    private let httpResponseCodeSuccessRange = (200..<300)
    private let session: URLSessionable

    /// Initializes the network session
    /// - Parameter session: network session through which connection will be stablished with remote server. Defaults to Foundation `URLSession.shared`
    public init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }

    /// Triggers a generic request in an asynchronous matter
    ///
    /// Example of usage:
    ///
    ///      let endpointRequest = URLRequest(url: URL(validURL: "github.com"))
    ///      let sessionManager = RequestManager()
    ///      sessionManager.request(endpointRequest) { result in
    ///          switch(result) in
    ///          case success(let response):
    ///          // do whatever you wish with NetworkResult resulting type
    ///          case failure(let errorType):
    ///          // handle error appropriately
    ///      }
    ///
    /// - Parameters:
    ///   - request: URL request specifications
    ///   - completion: Resulting completion closure from request
    public func request(_ request: URLRequest, completion: @escaping NetworkResult) {
        session.dataTaskWithURL(request) { data, response, error in
            guard let requestResponse = response as? HTTPURLResponse else {
                debugPrint("Unable to parse response due to \(String(describing: error?.localizedDescription))")
                completion(.failure(.malformedRequest))
                return
            }

            guard let retrievedData = data else {
                debugPrint("Unable to parse data due to \(String(describing: error?.localizedDescription))")
                completion(.failure(.forbiddenResource))

                return
            }

            if httpResponseCodeSuccessRange.contains(requestResponse.statusCode) {
                completion(.success(retrievedData))
            } else {
                completion(.failure(NetworkError.buildError(from: requestResponse.statusCode)))
            }
        }.resume()
    }
}
