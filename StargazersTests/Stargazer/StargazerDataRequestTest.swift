//
//  StargazerDataRequestTest.swift
//  StargazersTests
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

class StargazerDataRequestTest: StargazersRequest {
    
    func searchRequest<T>(owner: String, repo: String, page: String, elementsPerPage: String, success: @escaping (T) -> Void, failure: @escaping ((NetworkError) -> Void)) where T : Decodable {
        
        if( owner != "not_found" ) {
            let filePath = Bundle.main.path(forResource: "stargazers_response_200", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))

            let decoder: JSONDecoder = JSONDecoder.init()
            let stargazers: [StargazerResponseDTO] = try! decoder.decode([StargazerResponseDTO].self, from: data)
            success(stargazers as! T)
        } else {
            failure(NetworkError.notFound("Owner not found!"))
        }
    }
    
}
