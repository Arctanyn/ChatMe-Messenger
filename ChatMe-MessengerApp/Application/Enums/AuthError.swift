//
//  AuthError.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 18.09.2022.
//

import Foundation

enum AuthError: LocalizedError {
    case invalidUserData
    case failedToCreateNewAccount
    
    var errorDescription: String? {
        switch self {
        case .invalidUserData:
            return "Incorrect email or password"
        case .failedToCreateNewAccount:
            return "We were unable to register your account"
        }
    }
}
