//
//  RecentMessage.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 08.10.2022.
//

import Foundation

struct RecentChat {
    let id: String
    let userId: String
    let userFirstName, userEmail: String
    let userLastName: String?
    var fullName: String {
        "\(userFirstName) \(userLastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    let profileImageData: Data?
    let lastMessage: String
    let date: Date
}
