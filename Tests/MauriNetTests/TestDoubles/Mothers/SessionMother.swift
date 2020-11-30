//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 29/11/20.
//

import Foundation
@testable import MauriNet

struct SessionMother {
    static func assembleChainableSession() -> Agent {
        let session = URLSessionMock()

        return Agent(urlSession: session)
    }
}
