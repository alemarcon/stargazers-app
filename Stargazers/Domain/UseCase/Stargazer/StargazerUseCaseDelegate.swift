//
//  StargazerUseCaseDelegate.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation

protocol StargazerUseCaseDelegate {

    /// Method delegate called when search query succeded.
    /// - Parameter result: Stargazer array returned from data layer
    func onSearchSucceeded(result: [Stargazer])
    
    /// Method delegate called when search query fails.
    /// - Parameter error: Error object with failure reasons.
    func onSearchFailed(error: NetworkError)
}
