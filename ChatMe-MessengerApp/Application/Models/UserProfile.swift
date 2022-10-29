//
//  UserProfile.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation

struct UserProfile: Codable {
    let id: String
    var firstName: String
    var lastName: String?
    var fullName: String {
        "\(firstName) \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var email: String
    var profileImageData: Data?
    
    init(id: String, firstName: String, lastName: String? = nil, email: String, profileImageData: Data? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImageData = profileImageData
    }
    
    init(id: String, data: DatabaseDocumentData) {
        self.id = id
        self.firstName = data[UserDataFields.firstName] as? String ?? ""
        self.lastName = data[UserDataFields.lastName] as? String ?? ""
        self.email = data[UserDataFields.email] as? String ?? ""
        self.profileImageData = data[UserDataFields.profileImage] as? Data
    }
}
