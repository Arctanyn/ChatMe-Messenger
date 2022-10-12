//
//  ChatTableViewCellViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 08.10.2022.
//

import Foundation

protocol ChatTableViewCellViewModel {
    var userProfileImageData: Data? { get }
    var username: String { get }
    var lastMessage: String { get }
}

final class ChatsTableViewCellViewModelImpl: ChatTableViewCellViewModel {
    var userProfileImageData: Data? {
        recentChat.user.profileImageData
    }
    
    var username: String {
        recentChat.user.fullName
    }
    
    var lastMessage: String {
        recentChat.lastMessage
    }
    
    private let recentChat: RecentChat

    init(recentChat: RecentChat) {
        self.recentChat = recentChat
    }
}
