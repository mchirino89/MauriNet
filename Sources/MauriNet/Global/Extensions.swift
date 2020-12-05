//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public extension URL {
    init(validURL: String) {
        self.init(string: validURL)!
    }
}

public extension URLComponents {
    init(validURL: String) {
        self.init(string: validURL)!
    }
}

public extension Collection where Element == URLQueryItem {
    /// Returns -if available- the value for a parameter query within a URL
    /// I.e.:
    /// let tweetURLAvatar = "https://wwww.twitter.com/avatar.png?width=500&&height=500"
    /// let components = URLComponent(validURL: tweetURLAvatar)
    /// components.queryItems?["width"] // 500
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}
