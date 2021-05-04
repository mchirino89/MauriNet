//
//  NetworkError.swift
//  
//
//  Created by Mauricio Chirino on 05/12/20.
//

import Foundation

/// Type of network error codes supported
public enum NetworkError: Int, Error, CaseIterable {
    /// The request was cancelled
    case cancelled = -999

    /// Unhandled error type
    case unknown = 1

    /// Indicates that the server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing). Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400)
    case malformedRequest = 400

    /// Indicates that the request has not been applied because it lacks valid authentication credentials for the target reSource.
    ///
    /// This status is similar to 403, but in this case, authentication is possible. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/401)
    case unauthorized = 401

    /// Indicates that the server understood the request but refuses to authorize it.
    ///
    /// This status is similar to 401, but in this case, re-authenticating will make no difference. The access is permanently forbidden and tied to the application logic, such as insufficient rights to a reSource. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403)
    case forbiddenResource = 403

    /// Indicates that the server can't find the requested reSource.
    ///
    /// Links that lead to a 404 page are often called broken or dead links. This status code does not indicate whether the reSource is temporarily or permanently missing. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404)
    case notFound = 404

    /// Indicates that the request method is known by the server but is not supported by the target reSource. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/405)
    case methodNotAllowed = 405

    /// Means that the server would like to shut down this unused connection.
    ///
    /// It is sent on an idle connection by some servers, even without any previous request by the client. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/408)
    case timeout = 408

    /// Indicates a request conflict with current state of the target reSource.
    ///
    ///  Conflicts are most likely to occur in response to a PUT request. For example, you may get a 409 response when uploading a file which is older than the one already on the server resulting in a version control conflict. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/409)
    case conflictOnReSource = 409

    /// Indicates that access to the target reSource has been denied.
    ///
    /// This happens with conditional requests on methods other than GET or HEAD when the condition defined by the If-Unmodified-Since or If-None-Match headers is not fulfilled. In that case, the request, usually an upload or a modification of a reSource, cannot be made and this error response is sent back. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/412)
    case preconditionFailed = 412

    /// Indicates that the request entity is larger than limits defined by server. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/413)
    case payloadTooLarge = 413

    /// Indicates the user has sent too many requests in a given amount of time ("rate limiting").
    ///
    /// A Retry-After header might be included to this response indicating how long to wait before making a new request. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429)
    case tooManyRequests = 429

    /// Indicates that the server encountered an unexpected condition that prevented it from fulfilling the request.
    ///
    /// This error response is a generic "catch-all" response. Usually, this indicates the server cannot find a better 5xx error code to response. Sometimes, server administrators log error responses like the 500 status code with more details about the request to prevent the error from happening again in the future. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/500)
    case serverDown = 500

    /// Indicates that the server, while acting as a gateway or proxy, received an invalid response from the upstream server. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/502)
    case badGateway = 502

    /// Indicates that the server is not ready to handle the request.
    ///
    /// Common causes are a server that is down for maintenance or that is overloaded. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time for the recovery of the service. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/503)
    case serviceUnavailable = 503

    /// Indicates that the server, while acting as a gateway or proxy, did not get a response in time from the upstream server that it needed in order to complete the request. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/504)
    case gatewayTimeout = 504

    /// Indicates that a method could not be performed because the server cannot store the representation needed to successfully complete the request. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/507)
    case insufficientStorage = 507

    /// Indicates that the server terminated an operation because it encountered an infinite loop while processing a request with "Depth: infinity". This status indicates that the entire operation failed. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/508)
    case infiniteLoop = 508

    /// Indicates that the client needs to authenticate to gain network access.
    ///
    /// This status is not generated by origin servers, but by intercepting proxies that control access to the network. Network operators sometimes require some authentication, acceptance of terms, or other user interaction before granting access (for example in an internet café or at an airport). They often identify clients who have not done so using their Media Access Control (MAC) addresses. Source: [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/511)
    case networkAuthenticationRequired = 511

    public var localizedDescription: String {
        switch self {
        case .unauthorized:
            return "ReSource unavailable due to restrictions level"
        case .malformedRequest:
            return "Poorly assembled HTTP request"
        case .serverDown:
            return "Server is down"
        case .notFound:
            return "ReSource missing"
        case .methodNotAllowed:
            return "Request's HTTP method isn't allowed for this endpoint"
        case .forbiddenResource:
            return "Authentication required"
        case .timeout:
            return "Server took too long to reply"
        case .cancelled:
            return "Request was cancelled"
        case .conflictOnReSource:
            return "There's an internal conflict with the requested reSource"
        case .preconditionFailed:
            return "Precondition failed for this request"
        case .serviceUnavailable:
            return "The requested service is unavailable at the moment"
        case .unknown:
            return "Unknown error"
        case .payloadTooLarge:
            return "The requested reSource is too large to be processed"
        case .tooManyRequests:
            return "The number of requests has exceeded the server limit"
        case .badGateway:
            return "Upstream server provided a bad response"
        case .gatewayTimeout:
            return "Upstream server took too long to respond"
        case .insufficientStorage:
            return "The server cannot store the requested reSource due to lack of storage"
        case .infiniteLoop:
            return "The operation requested generated an infinit loop"
        case .networkAuthenticationRequired:
            return "Please accept the terms and/or authenticate before trying again"
        }
    }

    /// Provides the HTTP error code attached to an specific case
    public var errorCode: Int {
        return rawValue
    }

    /// Builds a `NetworkError` from the given code
    /// - Parameter code: `Int` value representing the HTTP error to map
    /// - Returns: Mapped `NetworkError` object, should it be supported 
    public static func buildError(from code: Int) -> NetworkError {
        guard let errorCase = NetworkError(rawValue: code) else {
            return .unknown
        }

        return errorCase
    }
}
