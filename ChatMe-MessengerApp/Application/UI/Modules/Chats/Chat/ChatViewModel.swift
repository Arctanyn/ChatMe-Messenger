//
//  ChatViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation
import FirebaseAuth
import MessageKit

//MARK: ChatViewModel

protocol ChatViewModel {
    var senderId: String { get }
    var senderName: String { get }
    var senderProfileImageData: Data? { get }
    
    var recipientName: String { get }
    var recipientProfileImageData: Data? { get }
    
    var messages: ObservableObject<[Message]> { get }
    func sendMessage(kind: MessageKit.MessageKind)
    func fetchMessages()
    
    func backToChats()
}

//MARK: ChatViewModelImpl

final class ChatViewModelImpl: ChatViewModel {
    
    //MARK: Properties
    
    var senderId: String {
        currentUser.id
    }
    
    var senderName: String {
        currentUser.fullName
    }
    
    var senderProfileImageData: Data? {
        currentUser.profileImageData
    }
    
    var recipientName: String {
        recipient.fullName
    }

    var recipientProfileImageData: Data? {
        recipient.profileImageData
    }
    
    var messages: ObservableObject<[Message]> = ObservableObject(value: [])
    
    private let currentUser: UserProfile
    private let recipient: UserProfile
    
    private let chatManager: ChatManager
    private let coordinator: Coordinator

    //MARK: - Initialization

    init(currentUser: UserProfile, recipient: UserProfile, chatManager: ChatManager, coordinator: Coordinator) {
        self.currentUser = currentUser
        self.recipient = recipient
        self.chatManager = chatManager
        self.coordinator = coordinator
    }

    //MARK: - Methods

    func sendMessage(kind: MessageKit.MessageKind) {
        chatManager.sendMessage(kind: kind) { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    func fetchMessages() {
        chatManager.fetchMessages { [weak self] result in
            switch result {
            case .success(let messages):
                self?.messages.value = messages
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func backToChats() {
        guard let coordinator = coordinator as? ChatCoordinator else { return }
        coordinator.finishFlow?()
    }
}
