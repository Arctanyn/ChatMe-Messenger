//
//  UsersDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation
import FirebaseFirestore

final class UsersDatabaseManagerImpl: UsersDatabaseManager {

    //MARK: Properties
    
    private let databasePath: DatabasePath
    
    init(databasePath: DatabasePath) {
        self.databasePath = databasePath
    }

    //MARK: - Methods
    
    func addUser(withData data: PiecemealUser, userIdentifier id: String, completion: @escaping OptionalErrorClosure) {
        let dict: DatabaseDocumentData = [
            UserDataFields.firstName: data.firstName,
            UserDataFields.lastName: data.lastName as Any,
            UserDataFields.email: data.email,
            UserDataFields.password: data.password,
            UserDataFields.profileImage: data.profileImageData as Any
        ]
        
        databasePath.getUserDocument(id: id).setData(dict) { error in
            guard error == nil else {
                completion(UsersDatabaseError.faildefToAddData)
                return
            }
            completion(nil)
        }
    }
    
    func getUser(withID id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        databasePath.getUserDocument(id: id).getDocument { documentSnapshot, error in
            guard
                error == nil,
                let documentSnapshot, documentSnapshot.exists,
                let userData = documentSnapshot.data()
            else {
                completion(.failure(UsersDatabaseError.failedToGetData))
                return
            }
            
            let user = UserProfile(id: documentSnapshot.documentID, data: userData)
            completion(.success(user))
        }
    }
    
    func getUsers(withName name: String, completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        databasePath.usersCollection.getDocuments { querySnapshot, error in
            guard
                error == nil,
                let documents = querySnapshot?.documents
            else {
                completion(.failure(UsersDatabaseError.failedToGetData))
                return
            }
            
            var users = [UserProfile]()
            
            for document in documents {
                let userData = document.data()
                
                let firstName = userData[UserDataFields.firstName] as? String ?? ""
                let lastName = userData[UserDataFields.lastName] as? String ?? ""
                
                if firstName.isBeginWithString(name) || lastName.isBeginWithString(name) {
                    let user = UserProfile(id: document.documentID, data: userData)
                    users.append(user)
                }
            }
            
            completion(.success(users))
        }
    }
}

