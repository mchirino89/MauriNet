//
//  RequestManager.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
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

public struct RequestManager {
    private let httpResponseCodeSuccessRange = (200..<300)
    let session: URLSessionable

    public init(session: URLSessionable = URLSession.shared) {
        self.session = session
    }

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
