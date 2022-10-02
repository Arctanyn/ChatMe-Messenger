//
//  UsersDatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

protocol UsersDatabaseManager {
    func addUser(withData data: PiecemealUser, userIdentifier id: String, completion: @escaping OptionalErrorClosure)
    func getUser(withID id: String, completion: @escaping (Result<UserProfile, Error>) -> Void)
    func getUsers(withName name: String, completion: @escaping (Result<[UserProfile], Error>) -> Void)
}
