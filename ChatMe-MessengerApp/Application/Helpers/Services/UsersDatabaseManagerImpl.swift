//
//  UsersDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

final class UsersDatabaseManagerImpl: UsersDatabaseManager {
    
    //MARK: Properties
    
    private let databaseManager: DatabaseManager
    
    //MARK: - Initialization
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    //MARK: - Methods
    
    func addUser(withData data: UserModel, userIdentifier id: String, completion: @escaping OptionalErrorClosure) {
        let dict: [String: Any] = [
            "firstName": data.firstName!,
            "lastName": data.lastName ?? "",
            "email": data.email!,
            "password": data.password!,
            "profileImage": data.profileImageData ?? ""
        ]
        
        databaseManager.addData(dict, toCollection: .users, inDocument: id, completion: completion)
    }
    
    func getUser(withID id: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        databaseManager.getData(fromCollection: .users, inDocument: id) { result in
            switch result {
            case .success(let data):
                let user = UserModel(
                    firstName: data["firstName"] as? String,
                    lastName: data["lastName"] as? String,
                    email: data["email"] as? String,
                    password: data["password"] as? String,
                    profileImageData: data["profileImage"] as? Data
                )
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
