//
//  RequestsMother.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Combine
import Foundation

struct RequestsMother {
    func buildRequestWithSingleResponse() -> AnyPublisher<DummyDecodable, Error> {
        let dummyRequest = URLRequest(url: URL(string: "lala")!)
        let mockChain = SessionMother.assembleChainableSession()

        return mockChain.run(dummyRequest)
            .compactMap { $0 as? DummyDecodable }
            .eraseToAnyPublisher()
    }

    func buildRequests<T: Decodable>() -> AnyPublisher<T, Error> {
        let dummyRequest = URLRequest(url: URL(string: "lala")!)
        let mockChain = SessionMother.assembleChainableSession()

        return mockChain.run(dummyRequest)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
