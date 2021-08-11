//
//  StargazersRouter.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation
import Alamofire

enum StargazersRouter: APIConfiguration {
    
    case search(owner: String, repo: String, page: String, elementsPerPage: String)
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search(let owner, let repo, _, _):
            return API.baseURL + "/repos/\(owner)/\(repo)/stargazers"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .search(_, _, let page, let elementsPerPage):
            return [
                "per_page": elementsPerPage,
                "page": page
            ]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .search:
            return [
                HTTPHeaderField.acceptType.rawValue: ContentType.vndGithub.rawValue
            ]
        }
    }
    
    var interceptor: RequestInterceptor? {
        switch self {
        case .search:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var url: URL
        do {
            url = try path.asURL()
        } catch {
            print("Error making url from path --> \(path)")
            url = URL(string: API.baseURL)!
        }
        
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.headers = headers
        
        if let parameters = parameters as? [String: String] {
            switch method {
            case .get:
                urlRequest = try URLEncodedFormParameterEncoder().encode(parameters, into: urlRequest)
            case .post:
                urlRequest = try JSONParameterEncoder().encode(parameters, into: urlRequest)
            default:
                urlRequest = try URLEncodedFormParameterEncoder().encode(parameters, into: urlRequest)
            }
        }
        
        return urlRequest
        
    }
    
}
