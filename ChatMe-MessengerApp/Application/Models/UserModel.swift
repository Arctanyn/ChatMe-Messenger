//
//  PiecemealUser.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import Foundation

struct UserModel: Codable {
    var name, lastName: String?
    var email, password: String?
    var profileImageData: Data?
}
