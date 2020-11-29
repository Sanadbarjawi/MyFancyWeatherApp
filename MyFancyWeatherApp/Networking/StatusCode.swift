//
//  StatusCode.swift
//  MyFancyWeatherApp
//
//  Created by Sanad Barjawi on 28/11/2020.
//

import Foundation

/**
 My own statusCode options.

 ````
 case OK
 case CREATED
 case NO_CONTENT
 case ACCEPTED
 case NOT_FOUND
 case UNAUTHORIZED
 case BAD_REQUEST
 case CONFLICT
 case SERVICE_UNAVAILABLE
 case BAD_GATEWAY
 ````
 */
enum StatusCode: Int {
    //MARK:- HTTP Status Codes

    /// It request status code the value 200 ok Sucess .
    case  ok = 200

    /// It request status code the value 201 created Sucess .
    case created = 201

    /// It request status code the value 204 noContent Sucess .
    case noContent = 204

    /// It request status code the value 202 accepted Sucess .
    case accepted = 202

    /// It request status code the value 206 partialContent Sucess .
    case  partialContent = 206

    /// It request status code the value 404 notFound FAILURE Client side .
    case notFound = 404

    /// It request status code the value 401 unauthorized FAILURE Client side .
    case unauthorized = 401

    /// It request status code the value 400 badRequest  FAILURE Client side `Error in my params` .
    case badRequest = 400

    /// It request status code the value 403 forbidden  FAILURE Client side .
    case forbidden = 403

    /// The request took longer than the server was prepared to wait.
    case timeout = 408

    /// Conflict: 409
    case conflict = 409

    /// It request status code the value 503 serviceUnavailable  retry request  .
    case serviceUnavailable = 503

    /// It request status code the value 502 badGateway  retry request  .
    case  badGateway = 502

    /// It request status code the value 500 internalError .
    case internalError = 500

//MARK:- URL Loading System Codes

    case NSURLErrorTimedOut = -1001

    case NSURLErrorNotConnectedToInternet = -1009

    case NSURLErrorClientCertificateRejected = -1205

    case NSURLErrorCannotConnectToHost = -1004

    case unknown = -900

}

extension StatusCode {

    /// Success - The action was successfully received, understood, and accepted.
    public var isSuccess: Bool {
        return isIn(range: 200...204)
    }

    /// Client Error - The request contains bad syntax or cannot be fulfilled.
    public var isClientError: Bool {
        return isIn(range: 400...409)
    }
    /// Server Error - The server failed to fulfill an apparently valid request.
    public var isServerError: Bool {
        return isIn(range: 500...503)
    }


    /// - returns: `true` if the status code is in the provided range, false otherwise.
    private func isIn(range: ClosedRange<StatusCode.RawValue>) -> Bool {
        return range.contains(rawValue)
    }
}

extension StatusCode {

    init?(_ httpResponse: HTTPURLResponse?) {
        guard let statusCodeValue = httpResponse?.statusCode else {
            return nil
        }
        self.init(statusCodeValue)
    }

    private init?(_ rawValue: Int) {
        guard let value = StatusCode(rawValue: rawValue) else {
            return nil
        }
        self = value
    }

}
