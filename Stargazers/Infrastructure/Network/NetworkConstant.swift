//
//  NetworkConstant.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case appVersion = "versione"
    case operatingSystem = "os"
}


enum ContentType: String {
    case all = "*/*"
    case json = "application/json"
    case xForm = "application/x-www-form-urlencoded"
    case vndGithub = "application/vnd.github.v3.star+json"
}


enum NetworkStatusCode: Int {
    
    //MARK: -  Undefined error
    case undefined              = 0
    
    //MARK: -  2xx Success
    case success                = 200
    case noContent              = 204
    
    //MARK: -  4xx Client errors
    case badRequest             = 400
    case unauthorized           = 401
    case forbidden              = 403
    case notFound               = 404
    case methodNotAllowed       = 405
    case conflict               = 409
    case unsupportedMediaType   = 415
    case preconditionRequired   = 428
    
    //MARK: - 5xx Server errors
    case internalServerError    = 500
    case notImplemented         = 501
    case badGateway             = 502
    case serviceUnavailable     = 503
    case gatewayTimeout         = 504
}
