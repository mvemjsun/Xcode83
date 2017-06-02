//
//  xcode832UITests.swift
//  xcode832UITests
//
//  Created by Teng, Puneet on 26/05/2017.
//  Copyright © 2017 . All rights reserved.
//

import XCTest

class xcode832UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLaunchAndSendToBG()  {
        let element1 = XCUIApplication().staticTexts["Country Name from ISO3 code"]
        let element2 = XCUIApplication().textFields["Enter 3 letter Country Code"]
        let result1 = waitFor(element: element1)
        XCTAssertTrue(result1)
        XCUIDevice.shared().press(XCUIDeviceButton.home)
        XCUIDevice.shared().siriService.activate(voiceRecognitionText: "open xcode832")
        let result2 = waitFor(element: element2)
        XCTAssertTrue(result2)
    }

    func testGetAValidCountryCode() {
        let countryCodeTextInputElement = XCUIApplication().textFields.matching(identifier: "countryCodeField").element(boundBy: 0)
        let countryDescription = XCUIApplication().textFields["Australia"]
        let getInfoButton = XCUIApplication().buttons.matching(identifier: "getCountryInfo").element(boundBy: 0)
        let readyToInput = XCUIApplication().staticTexts["Enter 3 letter Country Code"]
        
        _ = waitFor(element: readyToInput)
        countryCodeTextInputElement.tap()
        countryCodeTextInputElement.typeText("AUS")
        getInfoButton.tap()
        XCTAssertTrue(waitFor(element: countryDescription))
        
    }
    
    func testGetAnInvalidCountryCode() {
        let countryCodeTextInputElement = XCUIApplication().textFields.matching(identifier: "countryCodeField").element(boundBy: 0)
        let readyToInput = XCUIApplication().staticTexts["Enter 3 letter Country Code"]
        let getInfoButton = XCUIApplication().buttons.matching(identifier: "getCountryInfo").element(boundBy: 0)
        
        _ = waitFor(element: readyToInput)
        countryCodeTextInputElement.tap()
        countryCodeTextInputElement.typeText("XXX")
        getInfoButton.tap()
    }
    
    func waitFor(element e: XCUIElement) -> Bool {
        let p = NSPredicate(format: "exists == true")
        let e1 = XCTNSPredicateExpectation(predicate: p, object: e)
        let result = XCTWaiter.wait(for: [e1], timeout: 10)
        return (result == .completed)
    }
    
}
