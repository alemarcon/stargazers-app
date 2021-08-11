//
//  StargazerUseCase.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

protocol StargazerUseCase {

    var repository: StargazersRepository? { get set }
    var delegate: StargazerUseCaseDelegate? { get set }
    
    /// Method used to query stargazer repository
    /// - Parameters:
    ///   - owner: The owner of repo we would like to search
    ///   - repo: The repo name we would like to search
    ///   - page: The current page for paginated list
    ///   - elementsPerPage: Number of elements per page to show
    func search(for owner: String, repo: String, page: Int, elementsPerPage: Int)
}
