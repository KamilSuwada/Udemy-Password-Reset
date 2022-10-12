//
//  PaswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Kamil Suwada on 25/09/2022.
//

import XCTest
@testable import Password

class PasswordStatusViewTests: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp()
    {
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true
    }
    
    
    func testValidPassword() throws
    {
        statusView.shouldResetCriteria = true
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    
    func testTooShortPassword() throws
    {
        statusView.shouldResetCriteria = true
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }
    
    
    func testValidPasswordLossFocus() throws
    {
        statusView.shouldResetCriteria = false
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    
    func testTooShortPasswordLossFocus() throws
    {
        statusView.shouldResetCriteria = false
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
    }

}
