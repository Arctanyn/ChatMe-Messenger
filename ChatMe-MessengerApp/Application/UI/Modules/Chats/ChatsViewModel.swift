//
//  ChatsViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation

//MARK: ChatsViewModel

protocol ChatsViewModel {
    var numberOfChats: Int { get }
    func getChats(completion: @escaping VoidClosure)
    func startNewChat()
}

//MARK: - ChatsViewModelImpl

final class ChatsViewModelImpl: ChatsViewModel {
    
    //MARK: Properties
    
    var numberOfChats: Int = 0
    
    private let usersDatabaseManager: UsersDatabaseManager
    private let coordinator: Coordinator
    
    //MARK: - Initialization

    init(usersDatabaseManager: UsersDatabaseManager, coordinator: Coordinator) {
        self.usersDatabaseManager = usersDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func getChats(completion: @escaping VoidClosure) {
        
    }
    
    func startNewChat() {
        guard let coordinator = coordinator as? ChatsCoordinator else { return }
        coordinator.runStartNewChatFlow()
    }
}
