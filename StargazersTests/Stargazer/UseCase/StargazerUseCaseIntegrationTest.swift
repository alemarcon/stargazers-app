//
//  StargazerUseCaseIntegrationTest.swift
//  StargazersTests
//
//  Created by Alessandro Marcon on 10/08/2021.
//

import Foundation
import Swinject
import XCTest
@testable import Stargazers

class StargazerUseCaseIntegrationTest {
    
    private var expectation: XCTestExpectation
    private var xcTestCase: XCTestCase
    
    private var stargazerUseCase: StargazerUseCase?
    
    
    init(xcTestCase: XCTestCase) {
        // Initialize properties
        self.xcTestCase = xcTestCase
        expectation = XCTestExpectation(description: "Stargazer data: get correctly stargazers data")
    }
    
    /// Get summary data and check if it will be correctly decoded
    func runStargazersDataTest() {
        Assembler.type = .Test
        
        stargazerUseCase = Assembler.sharedAssembler.resolver.resolve(StargazerUseCase.self)
        stargazerUseCase?.delegate = self
        stargazerUseCase?.search(for: "octocat", repo: "hello-world", page: 1, elementsPerPage: 3)
        
        xcTestCase.wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test for not existing owner to be sure that failure event will be thrown
    func runFailureStargazersDataTest() {
        Assembler.type = .Test
        
        stargazerUseCase = Assembler.sharedAssembler.resolver.resolve(StargazerUseCase.self)
        stargazerUseCase?.delegate = self
        stargazerUseCase?.search(for: "not_found", repo: "repo", page: 1, elementsPerPage: 3)
        
        xcTestCase.wait(for: [expectation], timeout: 10.0)
    }
}

extension StargazerUseCaseIntegrationTest: StargazerUseCaseDelegate {
    
    func onSearchSucceeded(result: [Stargazer]) {
        XCTAssertTrue(result.count == 3)
        
        XCTAssertTrue(result[0].username == "schacon")
        XCTAssertTrue(result[0].starredAt == "26/01/2011 19:01")
        XCTAssertTrue(result[0].avatarUrl == "https://avatars.githubusercontent.com/u/70?v=4")
        
        XCTAssertTrue(result[1].username == "adelcambre")
        XCTAssertTrue(result[1].starredAt == "26/01/2011 19:01")
        XCTAssertTrue(result[1].avatarUrl == "https://avatars.githubusercontent.com/u/242?v=4")
        
        XCTAssertTrue(result[2].username == "usergenic")
        XCTAssertTrue(result[2].starredAt == "26/01/2011 19:01")
        XCTAssertTrue(result[2].avatarUrl == "https://avatars.githubusercontent.com/u/578?v=4")
        
        expectation.fulfill()
    }
    
    func onSearchFailed(error: NetworkError) {
        XCTAssertTrue( error.networkErrorCode == .notFound )
        expectation.fulfill()
    }
}
