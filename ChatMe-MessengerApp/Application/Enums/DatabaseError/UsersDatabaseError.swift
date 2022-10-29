//
//  UsersDatabaseError.swift
//  ChatMe-MessengerApp
//
//  Created by Malil Dugulyubgov on 29.10.2022.
//

import Foundation

enum UsersDatabaseError: LocalizedError {
    case failedToGetData
    case faildefToAddData
    
    var errorDescription: String? {
        switch self {
        case .failedToGetData:
            return "Data could not be retrieved from database"
        case .faildefToAddData:
            return "Failed to add data to the database"
        }
    }
}
