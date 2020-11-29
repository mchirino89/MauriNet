//
//  Agent.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Combine
import Foundation

/// Response object resulting from network request
public struct Response<T> {
    /// Generic value type from request's response
    let value: T

    /// Useful for logging purposes and HTTP low level debugging
    let response: URLResponse
}

/// Promise-based agent for network requests executions.
/// [Source](https://www.vadimbulavin.com/modern-networking-in-swift-5-with-urlsession-combine-framework-and-codable/)
public struct Agent {
    private let urlSession: URLSession

    /// Initializes an agent for a `URLSession`
    /// - Parameter urlSession: session where agent will live. Defaults to `.shared`
    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Runs the agent for given request
    ///
    /// Example of usage:
    ///
    ///      func executeAgentFor(urlString: String) -> AnyPublisher<Decodable, Error> {
    ///          let agent = Agent()
    ///          let request = URLRequest(url: urlString)
    ///
    ///          return agent.run(request)
    ///              .map(\.value)
    ///              .eraseToAnyPublisher()
    ///      }
    ///
    ///
    /// - Parameters:
    ///   - request: request to be performed by the agent
    ///   - decoder: type of decoding for request. Defaults to `JSONDecoder` instance
    /// - Returns: chainable response `AnyPublisher` object
    public func run<T: Decodable>(_ request: URLRequest,
                                  _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        urlSession
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)

                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
