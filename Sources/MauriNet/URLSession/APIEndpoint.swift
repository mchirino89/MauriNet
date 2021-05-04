//
//  APIEndpoint.swift
//
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation

/// Helper object that centralize all required parameters for an endpoint
public struct APIEndpoint {
    /// root URL. I.e. _github.com_, _developer.apple.com_ and so forth. Ending slash (`/`) is not required; in case a path is provided it'll be automatically added for those cases.
    public let host: String

    /// HTTP method for this endpoint
    public let httpMethod: HTTPMethod

    /// endpoint http scheme that defines what kind of connection is
    public let scheme: APIScheme

    /// timeout before the request expires
    public let timeout: TimeInterval

    /// Creates an `APIEndpoint` with the set of given values
    /// - Parameters:
    ///   - host: root URL. I.e. _github.com_, _developer.apple.com_ and so forth. Ending slash (`/`) is not required; in case a path is provided it'll be automatically added for those cases.
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
    /// - Parameter queryDictionary: param query in the form of a dictionary to be assembled into the resulting URLRequest. Defaults to an empty one
    /// - Returns: The assembled URL.
    ///
    public func buildRequest(for path: String, with queryDictionary: [String: String] = [:]) -> URLBuilderResult {
        let assembledURL = scheme.value + host + "/\(path)"
        var components = URLComponents(validURL: assembledURL)

        if !queryDictionary.isEmpty {
            components.queryItems = buildQuery(basedOn: queryDictionary)
        }

        if let builtURL = components.url {
            var request = URLRequest(url: builtURL, timeoutInterval: timeout)
            request.httpMethod = httpMethod.value

            return .success(request)
        } else {
            return .failure(.poorAssembling)
        }
    }

    private func buildQuery(basedOn dictionary: [String: String]) -> [URLQueryItem] {
        return dictionary.reduce([URLQueryItem]()) { assembled, item in
            assembled + [URLQueryItem(name: item.key, value: item.value)]
        }
    }
}
