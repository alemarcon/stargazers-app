//
//  StargazersRepository.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

protocol StargazersRepository {
    
    var request: StargazersRequest? { get }
    
    func search(owner: String, repo: String, page: String, elementsPerPage: String, success: @escaping ([Stargazer])->Void, failure: @escaping (NetworkError)->Void)
}
