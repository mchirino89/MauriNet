//
//  Constans.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public typealias URLBuilderResult = Result<URLRequest, URLBuilderError>

public enum URLBuilderError: Error {
    case poorAssembling
}

public enum APIScheme: String {
    case safe = "https"
    case unsafe = "http"

    var value: String {
        return rawValue + "://"
    }
}
