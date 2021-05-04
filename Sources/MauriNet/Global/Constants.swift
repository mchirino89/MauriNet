//
//  Constans.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

/// Custom type for resulting object from `APIEndpoint` built request
public typealias URLBuilderResult = Result<URLRequest, URLBuilderError>

/// Custom error type for `APIEndpoint` built request
public enum URLBuilderError: Error {
    /// The endpoint was not assembled properly
    case poorAssembling
}

/// Types of HTTP scheme
public enum APIScheme: String {
    /// secure scheme
    case safe = "https"

    /// insecure scheme
    case unsafe = "http"

    /// scheme value appending _://_
    ///
    /// Example of usage:
    ///
    ///      APIScheme.safe.value
    ///      // returns -> https://
    var value: String {
        return rawValue + "://"
    }
}
