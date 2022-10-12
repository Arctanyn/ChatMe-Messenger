//
//  ChatsViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation

//MARK: ChatsViewModel

protocol ChatsViewModel {
    var chats: ObservedObject<[RecentChat]> { get }
    func getChats()
    func startNewChat()
    func viewModelForCell(at indexPath: IndexPath) -> ChatTableViewCellViewModel
    func goToChatWithUser(at indexPath: IndexPath)
}

//MARK: - ChatsViewModelImpl

final class ChatsViewModelImpl: ChatsViewModel {
    
    //MARK: Properties

    var chats: ObservedObject<[RecentChat]> = ObservedObject(value: [])

    private let chatsDatabaseManager: ChatsDatabaseManager
    private let coordinator: Coordinator
    let usersDatabase = UsersDatabaseManagerImpl()
    
    //MARK: - Initialization

    init(chatsDatabaseManager: ChatsDatabaseManager, coordinator: Coordinator) {
        self.chatsDatabaseManager = chatsDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func getChats() {
        chatsDatabaseManager.fetchRecentChats()
        
        chatsDatabaseManager.chats.bind { [weak self] chats in
            self?.chats.value = chats
        }
    }
    
    func startNewChat() {
        guard let coordinator = coordinator as? ChatsCoordinator else { return }
        coordinator.runStartNewChatFlow()
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> ChatTableViewCellViewModel {
        let chat = chats.value[indexPath.row]
        return ChatsTableViewCellViewModelImpl(recentChat: chat)
    }
    
    func goToChatWithUser(at indexPath: IndexPath) {
        guard let coordinator = coordinator as? ChatsCoordinator else { return }
        let chat = chats.value[indexPath.row]
        let user = chat.user
        coordinator.goToChat(with: user)
    }
}
