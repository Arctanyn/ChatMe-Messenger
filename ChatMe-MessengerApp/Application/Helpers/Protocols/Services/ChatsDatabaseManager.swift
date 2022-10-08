//
//  ChatsDatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation
import MessageKit

protocol ChatsDatabaseManager {
    var chats: ObservableObject<[RecentChat]> { get }
    func fetchRecentChats()
}
