//
//  StargazerViewModel.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation
import Bond

//MARK: - Input protocol
protocol StargazerViewModelInput {
    
    /// Search on use case for repository
    /// - Parameters:
    ///   - owner: Repository owner
    ///   - repository: Repository name
    func search(for owner: String, repository: String)
    
    ///
    func loadMoreElements()
    
    /// Set number of elements to show in page
    /// - Parameter elements: Int rappresent number of element to get for each http call
    func setElementsPerPage(_ elements: Int)
}

//MARK: - Output protocol
protocol StargazerViewModelOutput {
    var status: Observable<StargazerViewModelStatus> { get }
    var useCase: StargazerUseCase? { get set }
    var stargazer: [Stargazer]? { get }
    var errorMessage: String? { get }
}

//MARK: - Status observable
enum StargazerViewModelStatus {
    case none
    case searching
    case success
    case failure
}

//MARK: - Default implementation
protocol StargazerViewModel: StargazerViewModelInput, StargazerViewModelOutput { }

class StargazerViewModelDefault: StargazerViewModel {
    
    var status: Observable<StargazerViewModelStatus> = Observable(.none)
    var useCase: StargazerUseCase?
    var stargazer: [Stargazer]?
    var errorMessage: String?
    
    private var error: NetworkError?
    private var _elementsPerPage = 30
    private var _currentPage = 1
    private var _hasMoreToLoad = true
    private var _owner = ""
    private var _repository = ""
    
    func search(for owner: String, repository: String) {
        stargazer = nil
        error = nil
        status.value = .searching
        _owner = owner
        _repository = repository
        _currentPage = 1
        useCase?.search(for: _owner, repo: _repository, page: _currentPage, elementsPerPage: _elementsPerPage)
    }
    
    func loadMoreElements() {
        if( _hasMoreToLoad && status.value != .searching) {
            status.value = .searching
            _currentPage = _currentPage + 1
            useCase?.search(for: _owner, repo: _repository, page: _currentPage, elementsPerPage: _elementsPerPage)
        }
    }
    
    func setElementsPerPage(_ elements: Int) {
        if( elements > 0 && elements < 100 ) {
            _elementsPerPage = elements
        } else {
            _elementsPerPage = 30
        }
    }
    
}

//MARK: - Usecase delegate

extension StargazerViewModelDefault: StargazerUseCaseDelegate {
    
    func onSearchSucceeded(result: [Stargazer]) {
        print("Success - \(result.count) elements found.")
        error = nil
        errorMessage = nil
        if( _currentPage == 1 ) {
            stargazer = [Stargazer]()
        }
        
        _hasMoreToLoad = result.count > 0
        stargazer?.append(contentsOf: result)
        
        print("\(stargazer?.count ?? 0) elements in list")
        
        status.value = .success
    }
    
    func onSearchFailed(error: NetworkError) {
        print("Error \(error.localizedDescription)")
        self.error = error
        if( error.networkErrorCode == .noConnection ) {
            errorMessage = error.errorDescription
        } else {
            errorMessage = "Non trovato"
        }
        status.value = .failure
    }
    
}
