//
//  StargazerRepositoryTest.swift
//  StargazersTests
//
//  Created by Alessandro Marcon on 11/08/2021.
//

import XCTest
@testable import Stargazers

class StargazerRepositoryTest: XCTestCase {

    /// Unit test for stargazers API model. Data source is from locale JSON file
    /// - Throws: <#description#>
    func testStargazRequest() throws {
        let stargaterTest = StargazersIntegrationRepositoryTest(xcTestCase: self)
        stargaterTest.runStargazersDataTest()
    }

}
