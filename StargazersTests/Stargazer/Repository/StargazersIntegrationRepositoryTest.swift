//
//  StargazersIntegrationRepositoryTest.swift
//  StargazersTests
//
//  Created by Alessandro Marcon on 11/08/2021.
//

import Foundation
import Swinject
import XCTest
@testable import Stargazers

class StargazersIntegrationRepositoryTest {
    
    private var expectation: XCTestExpectation
    private var xcTestCase: XCTestCase
    
    private var repository: StargazersRepository?
    
    
    init(xcTestCase: XCTestCase) {
        // Initialize properties
        self.xcTestCase = xcTestCase
        expectation = XCTestExpectation(description: "Stargazer repository: check for repository")
    }
    
    /// Get summary data and check if it will be correctly decoded
    func runStargazersDataTest() {
        Assembler.type = .Test
        
        repository = Assembler.sharedAssembler.resolver.resolve(StargazersRepository.self)
        repository?.search(owner: "octocat", repo: "hello-worls", page: "1", elementsPerPage: "3", success: { (stargazers) in
            XCTAssertTrue(stargazers.count == 3)
            
            XCTAssertTrue(stargazers[0].username == "schacon")
            XCTAssertTrue(stargazers[0].starredAt == "26/01/2011 19:01")
            XCTAssertTrue(stargazers[0].avatarUrl == "https://avatars.githubusercontent.com/u/70?v=4")
            
            XCTAssertTrue(stargazers[1].username == "adelcambre")
            XCTAssertTrue(stargazers[1].starredAt == "26/01/2011 19:01")
            XCTAssertTrue(stargazers[1].avatarUrl == "https://avatars.githubusercontent.com/u/242?v=4")
            
            XCTAssertTrue(stargazers[2].username == "usergenic")
            XCTAssertTrue(stargazers[2].starredAt == "26/01/2011 19:01")
            XCTAssertTrue(stargazers[2].avatarUrl == "https://avatars.githubusercontent.com/u/578?v=4")
            
        }, failure: { (error) in
            XCTFail()
        })

    }
    
}
