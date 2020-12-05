//
//  File.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public enum URLError: Error {
    case poorAssembling
}

public enum APIScheme: String {
    case safe = "https"
    case unsafe = "http"

    var value: String {
        return rawValue + "://"
    }
}
