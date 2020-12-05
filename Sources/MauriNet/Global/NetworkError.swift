//
//  NetworkError.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

public enum NetworkError: Int, Error, CaseIterable {
    case cancelled = -999
    case unknown = 1
    case unauthorized = 401
    case malformedRequest = 400
    case forbiddenResource = 403
    case notFound = 404
    case methodNotAllowed = 405
    case timeout = 408
    case conflictOnResource = 409
    case preconditionFailed = 412
    case serverDown = 500
    case serviceUnavailable = 503

    public var localizedDescription: String {
        switch self {
        case .unauthorized:
            return "Resource unavailable due to restrictions level"
        case .malformedRequest:
            return "Poorly assembled HTTP request"
        case .serverDown:
            return "Server is down"
        case .notFound:
            return "Resource missing"
        case .methodNotAllowed:
            return "Request's HTTP method isn't allowed for this endpoint"
        case .forbiddenResource:
            return "Authentication required"
        case .timeout:
            return "Server took too long to reply"
        case .cancelled:
            return "Request was cancelled"
        case .conflictOnResource:
            return "There's an internal conflict with the requested resource"
        case .preconditionFailed:
            return "Precondition failed for this request"
        case .serviceUnavailable:
            return "The requested service is unavailable at the moment"
        case .unknown:
            return "Unknown error"
        }
    }

    /// Provides the HTTP error code attached to an specific case
    public var errorCode: Int {
        return rawValue
    }

    public static func buildError(from code: Int) -> NetworkError {
        guard let errorCase = NetworkError(rawValue: code) else {
            return .unknown
        }

        return errorCase
    }
}
