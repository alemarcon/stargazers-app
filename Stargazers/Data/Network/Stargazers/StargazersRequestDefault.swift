//
//  StargazersRequestDefault.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation
import Alamofire

/// Default implementation of StargazersRequest protocol
class StargazersRequestDefault: StargazersRequest {
    
    func searchRequest<T>(owner: String, repo: String, page: String, elementsPerPage: String, success: @escaping (T) -> Void, failure: @escaping ((NetworkError) -> Void)) where T : Decodable {
        
        let router = StargazersRouter.search(owner: owner, repo: repo, page: page, elementsPerPage: elementsPerPage)
        _ = NetworkRequestPerfomer.performRequest(route: router, success: success, failure: failure)
        
    }

}
