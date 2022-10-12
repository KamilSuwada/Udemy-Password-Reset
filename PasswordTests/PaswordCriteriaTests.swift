//
//  PaswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Kamil Suwada on 25/09/2022.
//

import XCTest
@testable import Password


final class PasswordCriteriaLengthTests: XCTestCase
{

    override func setUpWithError() throws
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test7() throws
    {
        var text = ""
        for _ in 0..<7 { text += "1" }
        
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet(text))
    }
    
    
    func test8() throws
    {
        var text = ""
        for _ in 0..<8 { text += "1" }
        
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet(text))
    }
    
    
    func test32() throws
    {
        var text = ""
        for _ in 0..<32 { text += "1" }
        
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet(text))
    }
    
    
    func test33() throws
    {
        var text = ""
        for _ in 0..<33 { text += "1" }
        
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet(text))
    }

}


final class PasswordCriteriaOtherTests: XCTestCase
{

    override func setUpWithError() throws
    {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSpace1() throws
    {
        let text = "abcd"
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet(text))
    }
    
    func testSpace2() throws
    {
        let text = "ab cd"
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet(text))
    }
    
    func testUpper1() throws
    {
        let text = "aBcd"
        XCTAssertTrue(PasswordCriteria.upperCaseMet(text))
    }
    
    func testUpper2() throws
    {
        let text = "abcd"
        XCTAssertFalse(PasswordCriteria.upperCaseMet(text))
    }
    
    func testLower1() throws
    {
        let text = "ABCD"
        XCTAssertFalse(PasswordCriteria.lowerCaseMet(text))
    }
    
    func testLower2() throws
    {
        let text = "ABCd"
        XCTAssertTrue(PasswordCriteria.lowerCaseMet(text))
    }
    
    func testDigit1() throws
    {
        let text = "abcd1"
        XCTAssertTrue(PasswordCriteria.digitMet(text))
    }
    
    func testDigit2() throws
    {
        let text = "abcde"
        XCTAssertFalse(PasswordCriteria.digitMet(text))
    }
    
    func testSpecial1() throws
    {
        let text = "abcd!"
        XCTAssertTrue(PasswordCriteria.specialCharMet(text))
    }
    
    func testSpecial2() throws
    {
        let text = "abcde"
        XCTAssertFalse(PasswordCriteria.specialCharMet(text))
    }

}
