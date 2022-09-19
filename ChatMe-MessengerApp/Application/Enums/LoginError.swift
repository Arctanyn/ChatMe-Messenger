//
//  LoginError.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import Foundation

enum LoginError: LocalizedError {
    case emptyField
    case invalidEmail
    case differentPasswords
    case shortPassword
    case missingName
    
    var errorDescription: String? {
        switch self {
        case .emptyField:
            return "All fields must be filled in"
        case .invalidEmail:
            return "Invalid email address"
        case .differentPasswords:
            return "Passwords must match"
        case .shortPassword:
            return "The password must contain at least 6 characters"
        case .missingName:
            return "You need to set the profile name"
        }
    }
}
