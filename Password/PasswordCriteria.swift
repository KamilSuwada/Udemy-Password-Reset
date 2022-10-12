//
//  PasswordCriteria.swift
//  Password
//
//  Created by Kamil Suwada on 25/09/2022.
//

import Foundation




struct PasswordCriteria
{
    // MARK: - Password length:
    
    
    static func lengthCriteriaMet(_ text: String) -> Bool
    {
        return text.count >= 8 && text.count <= 32
    }
    
    
    static func noSpaceCriteriaMet(_ text: String) -> Bool
    {
        return text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    
    static func lengthAndNoSpaceMet(_ text: String) -> Bool
    {
        return lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    
    // MARK: - Upper and lowecase:
    
    
    static func upperCaseMet(_ text: String) -> Bool
    {
        return text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    
    static func lowerCaseMet(_ text: String) -> Bool
    {
        return text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    
    // MARK: - Digit and special char:
    
    
    static func digitMet(_ text: String) -> Bool
    {
        return text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    
    
    static func specialCharMet(_ text: String) -> Bool
    {
        return text.range(of: "[!@#%^:()/\\\\]+", options: .regularExpression) != nil
    }
    
}
