//
//  StargazersUITests.swift
//  StargazersUITests
//
//  Created by Alessandro Marcon on 09/08/2021.
//

import XCTest

class StargazersUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // Since UI tests are more expensive to run, it's usually a good idea
        // to exit if a failure was encountered
        continueAfterFailure = false
        
        app = XCUIApplication()
        
        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    func testStargazerViewController() throws {
        app.launch()
        // Make sure we're displaying login view controller
        XCTAssertTrue(app.isDisplayingStargazerViewController)
        
        let errorContainerView = app.otherElements["viewContainerIdentifier"]
        XCTAssertFalse(errorContainerView.exists)
        
        let searchButton = app.buttons["Search"]
        XCTAssertFalse(searchButton.isEnabled)
        
        let ownertTextfield = app.textFields["ownerTextfieldIdentifier"]
        ownertTextfield.tap()
        ownertTextfield.typeText("aa")
        
        XCTAssertFalse(searchButton.isEnabled)
        
        ownertTextfield.tap()
        ownertTextfield.buttons["Clear text"].tap()
        
        let repoTextfield = app.textFields["repoTextfieldIdentifier"]
        repoTextfield.tap()
        repoTextfield.typeText("bb")
        
        XCTAssertFalse(searchButton.isEnabled)
        
        ownertTextfield.tap()
        ownertTextfield.typeText("aa")

        XCTAssertTrue(searchButton.isEnabled)

        searchButton.tap()
        XCTAssertTrue(errorContainerView.waitForExistence(timeout: TimeInterval(1.0)))
        
        ownertTextfield.tap()
        ownertTextfield.buttons["Clear text"].tap()
        ownertTextfield.typeText("octocat")
        
        repoTextfield.tap()
        repoTextfield.buttons["Clear text"].tap()
        repoTextfield.typeText("hello-world")
        
        let activityIndicator = app.activityIndicators.element
        searchButton.tap()
        
        // Wait 2 seconds to be sure that API response will be received
        XCTAssertFalse(activityIndicator.waitForExistence(timeout: TimeInterval(2.0)))
        XCTAssertFalse(errorContainerView.exists)
    }
    
}

extension XCUIApplication {
    
    var isDisplayingStargazerViewController: Bool {
        return otherElements["stargazerViewControllerIdentifier"].exists
    }
    
}
