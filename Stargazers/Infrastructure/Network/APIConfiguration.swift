//
//  APIConfiguration.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    /// Define HTTP method for network request
    var method: HTTPMethod { get }
    /// API Endpoint
    var path: String { get }
    /// API parameters
    var parameters: Parameters? { get }
    /// Header parameters
    var headers: HTTPHeaders { get }
    /// Interceptor class invoked prior to network call, used to inject parameters. Example, auth token.
    var interceptor: RequestInterceptor? { get }
}
