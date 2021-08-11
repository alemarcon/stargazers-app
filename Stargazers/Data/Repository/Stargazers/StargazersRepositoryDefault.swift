//
//  StargazersRepositoryDefault.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

/// Default implementation of StargazersRepository
class StargazersRepositoryDefault: StargazersRepository {
    
    var request: StargazersRequest?
    
    func search(owner: String, repo: String, page: String, elementsPerPage: String, success: @escaping ([Stargazer]) -> Void, failure: @escaping (NetworkError) -> Void) {
        print("Begin http response")
        
        request?.searchRequest(owner: owner, repo: repo, page: page, elementsPerPage: elementsPerPage, success: { (response: [StargazerResponseDTO]) in
            print("Response received")
            success( StargazerDTOMapper.toEntityArray(dtos: response) )
        }, failure: { (error) in
            print("Response failed! \(error.localizedDescription)")
            failure(error)
        })
        
    }
    
}
