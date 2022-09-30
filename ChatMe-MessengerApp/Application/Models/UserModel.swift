//
//  PiecemealUser.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import Foundation

struct UserModel: Codable {
    var firstName = ""
    var lastName: String?
    var fullName: String {
        "\(firstName) \(lastName ?? "")"
    }
    var email = ""
    var password = ""
    var profileImageData: Data?
}
