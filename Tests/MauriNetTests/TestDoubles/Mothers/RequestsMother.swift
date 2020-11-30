//
//  RequestsMother.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Combine
import Foundation
@testable import MauriNet

struct RequestsMother {
    static func buildRequests<T: Decodable>() -> AnyPublisher<T, Error> {
        let dummyRequest = URLRequest(url: URL(string: "lala")!)
        let mockChain = SessionMother.assembleChainableSession()

        return mockChain.run(dummyRequest)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
