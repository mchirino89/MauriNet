//
//  HTTPEncoding.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

/// Types of HTTP supported encoding 
enum HTTPEncoding {
    /// url type (i.e. used in `GET` requests)
    case url

    /// JSON type
    case json

    /// body type
    case body
}
