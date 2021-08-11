//
//  StargazersUseCaseTests.swift
//  StargazersUseCaseTests
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import XCTest
@testable import Stargazers

class StargazersUseCaseTests: XCTestCase {

    /// Unit test for stargazers API model. Data source is from locale JSON file
    /// - Throws: <#description#>
    func testStargazRequest() throws {
        let stargaterTest = StargazerUseCaseIntegrationTest(xcTestCase: self)
        stargaterTest.runStargazersDataTest()
    }
    
    func testStargazFailureRequest() throws {
        let stargaterTest = StargazerUseCaseIntegrationTest(xcTestCase: self)
        stargaterTest.runFailureStargazersDataTest()
    }

}
