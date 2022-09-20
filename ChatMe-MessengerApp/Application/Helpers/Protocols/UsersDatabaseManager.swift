//
//  UsersDatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

protocol UsersDatabaseManager {
    func addUser(withData data: UserModel, userIdentifier id: String, completion: @escaping OptionalErrorClosure)
}
