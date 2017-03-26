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
        XCUIApplication().buttons["Let's get started"].tap()
        
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"Basic info").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText("")
        
        let textField2 = element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField2.typeText("60")
        textField2.tap()
        textField2.tap()
        textField2.tap()
        textField2.typeText("300")
        
        let textField3 = element.children(matching: .other).element(boundBy: 2).children(matching: .textField).element
        textField3.tap()
        textField3.tap()
        textField3.tap()
        textField3.typeText("30")
        app.buttons["Continue"].tap()
        
        let textField4 = app.otherElements.containing(.navigationBar, identifier:"HackYourHealth.ExtraInfoView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0)
        textField4.tap()
        textField4.typeText("60")
        XCUIApplication().otherElements.containing(.navigationBar, identifier:"HackYourHealth.ExtraInfoView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1).tap()
        
        let button = app.buttons["3-5"]
        button.tap()
        button.tap()
        app.buttons["Get Results"].tap()
        
    }
    
}
