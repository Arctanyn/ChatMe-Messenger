//
//  ChatsViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation

//MARK: ChatsViewModel

protocol ChatsViewModel {
    var chats: ObservableObject<[RecentChat]> { get }
    func getChats()
    func startNewChat()
    func viewModelForCell(at indexPath: IndexPath) -> ChatTableViewCellViewModel
    func goToChatWithUser(at indexPath: IndexPath)
    func deleteChat(at indexPath: IndexPath)
    func usernameForChat(at indexPath: IndexPath) -> String
}

//MARK: - ChatsViewModelImpl

final class ChatsViewModelImpl: ChatsViewModel {
    
    //MARK: Properties

    var chats: ObservableObject<[RecentChat]> = ObservableObject(value: [])

    private let chatsDatabaseManager: ChatsDatabaseManager
    private let coordinator: Coordinator
    
    //MARK: - Initialization

    init(chatsDatabaseManager: ChatsDatabaseManager, coordinator: Coordinator) {
        self.chatsDatabaseManager = chatsDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func getChats() {
        chatsDatabaseManager.chats.value.removeAll()
        chatsDatabaseManager.fetchRecentChats()
        
        chatsDatabaseManager.chats.bind { [weak self] chats in
            self?.chats.value = chats
        }
    }
    
    func startNewChat() {
        guard let coordinator = coordinator as? ChatsCoordinator else { return }
        coordinator.runStartNewChatFlow()
    }
    
    func deleteChat(at indexPath: IndexPath) {
        let chat = chats.value[indexPath.row]
        chatsDatabaseManager.deleteChat(withId: chat.id, recipientId: chat.user.id)
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ChatTableViewCellViewModel {
        let chat = chats.value[indexPath.row]
        return ChatsTableViewCellViewModelImpl(recentChat: chat)
    }
    
    func usernameForChat(at indexPath: IndexPath) -> String {
        let user = chats.value[indexPath.row].user
        return user.fullName
    }
    
    func goToChatWithUser(at indexPath: IndexPath) {
        guard let coordinator = coordinator as? ChatsCoordinator else { return }
        let chat = chats.value[indexPath.row]
        let user = chat.user
        coordinator.goToChat(with: user)
    }
}
