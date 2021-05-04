//
//  HTTPMethod.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

/// HTTP methods supported 
public enum HTTPMethod {
    /// Representation of [GET](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET) method
    case get

    /// Representation of [POST](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/POST) method
    case post

    /// Representation of [PUT](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT) method
    case put

    /// Representation of [DELETE](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/DELETE) method
    case delete

    /// Uppercased string representation 
    var value: String {
        String(describing: self).uppercased()
    }
}
