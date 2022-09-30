//
//  UsersDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

final class UsersDatabaseManagerImpl: UsersDatabaseManager {
    
    //MARK: - UserDataFields
    
    enum UserDataFields {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let profileImage = "profileImage"
        static let email = "email"
        static let password = "password"
    }
    
    //MARK: Properties
    
    private let databaseManager: DatabaseManager
    
    //MARK: - Initialization
    
    init(databaseManager: DatabaseManager) {
        self.databaseManager = databaseManager
    }
    
    //MARK: - Methods
    
    func addUser(withData data: UserModel, userIdentifier id: String, completion: @escaping OptionalErrorClosure) {
        let dict: [String: Any] = [
            UserDataFields.firstName: data.firstName,
            UserDataFields.lastName: data.lastName ?? "",
            UserDataFields.email: data.email,
            UserDataFields.password: data.password,
            UserDataFields.profileImage: data.profileImageData ?? ""
        ]
        
        databaseManager.addData(dict, toCollection: .users, inDocument: id, completion: completion)
    }
    
    func getUser(withID id: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        databaseManager.getData(fromCollection: .users, inDocument: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let user = self.setupUser(with: data)
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUser(withName name: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        databaseManager.getDocuments(fromCollection: .users) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let documents):
                var users: [UserModel] = []
                
                for document in documents {
                    let userData = document.data()
                    
                    guard
                        let firstName = userData[UserDataFields.firstName] as? String,
                        let lastName = userData[UserDataFields.lastName] as? String
                    else {
                        continue
                    }
                    
                    let fullName = "\(firstName) \(lastName)"
                    if fullName.lowercased().contains(name.lowercased()) {
                        let user = self.setupUser(with: userData)
                        users.append(user)
                    }
                }
                
                completion(.success(users))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    private func setupUser(with data: [String: Any]) -> UserModel {
        return UserModel(
            firstName: data[UserDataFields.firstName] as? String ?? "",
            lastName: data[UserDataFields.lastName] as? String ?? "",
            email: data[UserDataFields.email] as? String ?? "",
            password: data[UserDataFields.password] as? String ?? "",
            profileImageData: data[UserDataFields.profileImage] as? Data
        )
    }
}
