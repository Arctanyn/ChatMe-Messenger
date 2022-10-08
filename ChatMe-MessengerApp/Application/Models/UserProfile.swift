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
}
