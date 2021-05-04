//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public extension URL {
    /// Assumes the provided string contains a valid URL. Recommended usage with static assembled URLs;
    /// for dynamic generated ones use failable init to avoid runtime crashes.
    /// - Parameter validURL: A valid URL according to [RFC 1738](https://tools.ietf.org/html/rfc1738)
    init(validURL: String) {
        self.init(string: validURL)!
    }
}

public extension URLComponents {
    /// Assumes the provided string contains a valid URL. Recommended usage with static assembled URLs;
    /// for dynamic generated ones use failable init to avoid runtime crashes.
    /// - Parameter validURL: A valid URL according to [RFC 1738](https://tools.ietf.org/html/rfc1738)
    init(validURL: String) {
        self.init(string: validURL)!
    }
}

/// Support for native `Collection` object formed by `URLQueryItem` items
public extension Collection where Element == URLQueryItem {
    /// Returns -if available- the value for a parameter query within a URL
    /// Example of usage:
    ///
    ///      let tweetURLAvatar = "https://wwww.twitter.com/avatar.png?width=500&&height=500"
    ///      let components = URLComponent(validURL: tweetURLAvatar)
    ///      components.queryItems?["width"] // 500
    ///
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}
