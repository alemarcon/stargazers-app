//
//  StargazersRequest.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation
import Alamofire

/// Stargazers reuqest protocol. Contains all methods related to stargazers info
protocol StargazersRequest {
    
    /// Execute HTTP reuqest to search for stargazers repo
    /// - Parameters:
    ///   - owner: Repo owner
    ///   - repo: Repo name
    ///   - page: Current page number for paginated list. Default value is 1
    ///   - elementsPerPage: Number of elements per page. Default value is 30, max value is 100
    ///   - success: Escape faired in success case
    ///   - failure: Escape fired in failure case
    func searchRequest<T: Decodable>(owner: String, repo: String, page: String, elementsPerPage: String, success: @escaping (T) -> Void, failure: @escaping ((NetworkError) -> Void))
}
