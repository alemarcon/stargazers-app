//
//  NetworkError.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation

enum NetworkErrorCode: Int {
    case notFound = 404
    case explicitlyCancelled = 500
    case generic = 600
    case jsonSerialization = 700
    case dataNil = 800
    case timeout = 900
    case noConnection = 1000
}


/// Custom error to throws network error
enum NetworkError: Error {
    
    /// Error throws in case of 404 HTTP error
    case notFound(String)
    /// Error throws in case of explicitly cancelled HTTP request
    case explicitlyCancelled
    /// Generic error throws in any other network error
    case generic(Int, String)
    /// Error throws in case of json serialization error
    case jsonSerialization
    /// Error throws in case of response data nil
    case dataNil
    //// Error throws in timeout case
    case timeout
    /// Error throws in case of missing internet connection
    case noConnection
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        
        case .notFound(let message):
            let format = NSLocalizedString("Ops, something went wrong. Error code 404, message: '%@'", comment: "")
            return String(format: format, String(message))
            
        case .explicitlyCancelled:
            return NSLocalizedString("Request explicitly cancelled.", comment: "")
            
        case .generic(let code, let message):
            let format = NSLocalizedString("Ops, something went wrong. Error code '%@', message: '%@'", comment: "")
            return String(format: format, String(code), String(message))
            
        case .jsonSerialization:
            return NSLocalizedString("JSON serialization error", comment: "")
            
        case .dataNil:
            return NSLocalizedString("Response data is nil.", comment: "")
        case .timeout:
            return NSLocalizedString("HTTP Timeout", comment: "")
        case .noConnection:
            return NSLocalizedString("Sembra che tu sia offline. Controlla la tua connessione e riprova.", comment: "")
        }
        
    }
    
    var networkErrorCode: NetworkErrorCode {
        switch self {
        case .notFound:
            return .notFound
        case .explicitlyCancelled:
            return .explicitlyCancelled
        case .generic:
            return .generic
        case .jsonSerialization:
            return .jsonSerialization
        case .dataNil:
            return .dataNil
        case .timeout:
            return .timeout
        case .noConnection:
            return .noConnection
        }
    }
}
