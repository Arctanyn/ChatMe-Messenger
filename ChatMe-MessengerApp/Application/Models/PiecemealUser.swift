//
//  PiecemealUser.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import Foundation

struct PiecemealUser: Codable {
    var firstName = ""
    var lastName: String?
    var email = ""
    var password = ""
    var profileImageData: Data?
}
