//
//  APIEndpoint.swift
//
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation

public struct APIEndpoint {
    let host: String
    let httpMethod: HTTPMethod
    let scheme: APIScheme
    let timeout: TimeInterval

    /// Creates an `APIEndpoint` with the set of given values
    /// - Parameters:
    ///   - host: root URL. I.e. _github.com_, _developer.apple.com_ and so forth
    ///   - httpMethod: type of HTTP method this endpoint will handle. Defaults to `.get` type
    ///   - scheme: whether or not this is a safe connection. Defaults to `.safe` type (https)
    ///   - timeout: timeout before the request expires. Defaults to `10` seconds
    public init(host: String,
                httpMethod: HTTPMethod = .get,
                scheme: APIScheme = .safe,
                timeout: TimeInterval = 10) {
        self.host = host
        self.httpMethod = httpMethod
        self.scheme = scheme
        self.timeout = timeout
    }

    /// Builds a complete URL from the `host` value, given a path
    ///
    /// Example of usage:
    ///
    ///      let githubEndpoint = APIEndpoint(host: "github.com")
    ///      githubEndpoint.buildRequest(for: "events")
    ///      // returns -> https://github.com/events
    ///
    /// - Parameter path: path (with or without query parameters) to append to the existing host
    /// - Returns: The assembled URL.
    ///
    public func buildRequest(for path: String) -> URLBuilderResult {
        let assembledURL = scheme.value + host + "/\(path)"
        let components = URLComponents(validURL: assembledURL)

        if let builtURL = components.url {
            var request = URLRequest(url: builtURL, timeoutInterval: timeout)
            request.httpMethod = httpMethod.value

            return .success(request)
        } else {
            return .failure(.poorAssembling)
        }
    }
}
