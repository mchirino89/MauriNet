//
//  EndpointBuilder.swift
//  
//
//  Created by Mauricio Chirino on 11/4/21.
//

import Foundation

/// Convenience endpoint builder handler
public struct EndpointBuilder {
    private let endpointSetup: APIEndpoint

    /// Instantiate the builder for the provided setup
    /// - Parameter endpointSetup: root endpoint setup from where all builder setup will bootstrap
    public init(endpointSetup: APIEndpoint) {
        self.endpointSetup = endpointSetup
    }

    /// Assembles an URL for the current host
    ///
    /// Example of usage:
    ///
    ///      let githubEndpoint = APIEndpoint(host: "github.com")
    ///      let endpointBuilder = EndpointBuilder(endpointSetup: githubEndpoint)
    ///      endpointBuilder.assembleRequest(path: "events") { result in
    ///          switch(result) in
    ///          case success(let assembledRequest):
    ///          // do whatever you wish with URLRequest resulting type
    ///          case failure(let errorType):
    ///          // defaults to an URLRequest for google.com
    ///      }
    ///
    /// - Parameters:
    ///   - path: path for the desired endpoint
    ///   - queryParameters: URL's query parameters, should they exist. Defaults to an empty dictionary (no parameters)
    /// - Returns: valid URL (defaults to [google.com](google.com) in case of error in assembly)
    public func assembleRequest(path: String, queryParameters: [String: String] = [:]) -> URLRequest {
        switch endpointSetup.buildRequest(for: path, with: queryParameters) {
        case .success(let assembledRequest):
            return assembledRequest
        case .failure:
            // TODO: this might be handled in a better way.
            return URLRequest(url: URL.init(validURL: "google.com"))
        }
    }
}
