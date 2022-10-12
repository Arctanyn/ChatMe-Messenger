//
//  UsersDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation
import FirebaseFirestore

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
    
    private let firestore = Firestore.firestore()

    //MARK: - Methods
    
    func addUser(withData data: PiecemealUser, userIdentifier id: String, completion: @escaping OptionalErrorClosure) {
        let dict: [String: Any] = [
            UserDataFields.firstName: data.firstName,
            UserDataFields.lastName: data.lastName as Any,
            UserDataFields.email: data.email,
            UserDataFields.password: data.password,
            UserDataFields.profileImage: data.profileImageData as Any
        ]

        firestore.collection(DatabaseCollection.users).document(id).setData(dict, completion: completion)
    }
    
    func getUser(withID id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        firestore.collection(DatabaseCollection.users).document(id).getDocument { [weak self] documentSnapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let self else { return }
            
            guard
                let documentSnapshot, documentSnapshot.exists,
                let userData = documentSnapshot.data()
            else {
                return
            }
            
            let user = self.setupUser(withId: documentSnapshot.documentID, data: userData)
            completion(.success(user))
        }
    }
    
    func getUsers(withName name: String, completion: @escaping (Result<[UserProfile], Error>) -> Void) {
        firestore.collection(DatabaseCollection.users).getDocuments { [weak self] querySnapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            guard let self else { return }
            var users = [UserProfile]()
            
            for document in documents {
                let userData = document.data()
                
                let firstName = userData[UserDataFields.firstName] as? String ?? ""
                let lastName = userData[UserDataFields.lastName] as? String ?? ""
                
                if firstName.isBeginWithString(name) || lastName.isBeginWithString(name) {
                    let user = self.setupUser(withId: document.documentID, data: userData)
                    users.append(user)
                }
                
            }
            
            completion(.success(users))
            
        }

    }
}

//MARK: - Private methods

private extension UsersDatabaseManagerImpl {
    func setupUser(withId id: String, data: [String: Any]) -> UserProfile {
        return UserProfile(
            id: id,
            firstName: data[UserDataFields.firstName] as? String ?? "",
            lastName: data[UserDataFields.lastName] as? String ?? "",
            email: data[UserDataFields.email] as? String ?? "",
            profileImageData: data[UserDataFields.profileImage] as? Data
        )
    }
}
