//
//  HTTPMethod.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case put
    case delete

    var value: String {
        String(describing: self).uppercased()
    }
}
