//
//  LoginError.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import Foundation

enum LoginError: LocalizedError {
    case emptyField
    case invalidUserData
    case differentPasswords
    case missingName
    
    var errorDescription: String? {
        switch self {
        case .emptyField:
            return "All fields must be filled in"
        case .invalidUserData:
            return "Incorrect email or password"
        case .differentPasswords:
            return "Passwords must match"
        case .missingName:
            return "You need to set the profile name"
        }
    }
}
