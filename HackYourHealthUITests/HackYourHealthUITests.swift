//
//  HackYourHealthUITests.swift
//  HackYourHealthUITests
//
//  Created by Michele Wang on 3/26/17.
//  Copyright © 2017 Ben Cullen. All rights reserved.
//

import XCTest

class HackYourHealthUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()

        // MARK: Welcome
        app.buttons["Let's get started"].tap()

        // MARK: Basic
        var element = app.otherElements.containing(.navigationBar, identifier:"Basic Info")
        var textField = element.textFields.element(boundBy: 0)
        textField.tap()
        textField.typeText("59.8")

        textField = element.textFields.element(boundBy: 1)
        textField.tap()
        textField.typeText("165.6")

        textField = element.textFields.element(boundBy: 2)
        textField.tap()
        textField.typeText("30")
        app.buttons["Continue"].tap()

        // MARK: Extra
        element = app.otherElements.containing(.navigationBar, identifier:"Extra Info")
        textField = element.textFields.element(boundBy: 0)
        textField.tap()
        textField.typeText("60")

        textField = element.textFields.element(boundBy: 1)
        textField.tap()
        textField.typeText("1000")

        app.buttons["3-5"].tap()
        app.buttons["Get Results"].tap()
    }
    
}
