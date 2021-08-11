//
//  StargazerUseCaseDefault.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

class StargazerUseCaseDefault: StargazerUseCase {
    
    var repository: StargazersRepository?
    var delegate: StargazerUseCaseDelegate?
    
    func search(for owner: String, repo: String, page: Int, elementsPerPage: Int) {
        
        repository?.search(owner: owner, repo: repo, page: String(page), elementsPerPage: String(elementsPerPage), success: { (stargazers) in
            self.delegate?.onSearchSucceeded(result: stargazers)
        }, failure: { (error) in
            self.delegate?.onSearchFailed(error: error)
        })
        
    }
    
}
