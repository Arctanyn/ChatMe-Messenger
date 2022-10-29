//
//  ChatDatabaseError.swift
//  ChatMe-MessengerApp
//
//  Created by Malil Dugulyubgov on 29.10.2022.
//

import Foundation

enum ChatDatabaseError: LocalizedError {
    case failedToSendMessage
    case failledToRecieveMessages
    
    var errorDescription: String? {
        switch self {
        case .failedToSendMessage:
            return "Failed to send message"
        case .failledToRecieveMessages:
            return "Failed to recieve chat messages"
        }
    }
    
}
