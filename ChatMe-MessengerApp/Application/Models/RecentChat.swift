//
//  RecentMessage.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 08.10.2022.
//

import Foundation
import FirebaseFirestore

struct RecentChat {
    let id: String
    let user: UserProfile
    let lastMessage: String
    let date: Date
    let kind: MessageDatabaseKind
    
    init(id: String, data: DatabaseDocumentData, userData: DatabaseDocumentData) {
        self.id = id
        self.user = UserProfile(
            id: userData[UserDataFields.id] as? String ?? "",
            data: userData
        )
        self.lastMessage = data[ChatDataFields.lastMessage] as? String ?? ""
        self.date = (data[ChatDataFields.date] as? Timestamp)?.dateValue() ?? Date()
        self.kind = MessageDatabaseKind(rawValue: (data[ChatDataFields.kind] as? String ?? "")) ?? .text
    }
}
