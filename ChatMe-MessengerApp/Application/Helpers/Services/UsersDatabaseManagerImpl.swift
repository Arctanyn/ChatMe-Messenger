//
//  UsersDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

final class UsersDatabaseManagerImpl: UsersDatabaseManager {
    private let databaseManager: DatabaseManager
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    func addUser(withData data: UserModel, userIdentifier id: String, completion: @escaping OptionalErrorClosure) {
        let dict: [String: Any] = [
            "email": data.email!,
            "password": data.password!,
            "username": data.name!,
            "lastName": data.lastName ?? "",
            "profileImage": data.profileImageData!
        ]
        
        databaseManager.addData(dict, toCollection: .users, inDocument: id, completion: completion)
    }
}
