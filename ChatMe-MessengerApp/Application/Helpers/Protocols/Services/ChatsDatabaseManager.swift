//
//  ChatsDatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation

protocol ChatsDatabaseManager {
    var chats: ObservedObject<[RecentChat]> { get }
    func fetchRecentChats()
}
