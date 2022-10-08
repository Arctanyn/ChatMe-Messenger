//
//  ChatManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 02.10.2022.
//

import Foundation
import FirebaseFirestore
import MessageKit

final class ChatManagerImpl: ChatManager {
    
    enum MessageDataFields {
        static let senderID = "sender_id"
        static let text = "text"
        static let date = "date"
    }

    //MARK: Properties
    private let sender: UserProfile
    private let recipient: UserProfile
    private let firestore = Firestore.firestore()
    private let chatsDatabaseManager: ChatsDatabaseManager
    
    //MARK: - Initialization
    
    init(sender: UserProfile, recipient: UserProfile, chatsDatabaseManager: ChatsDatabaseManager) {
        self.sender = sender
        self.recipient = recipient
        self.chatsDatabaseManager = chatsDatabaseManager
    }
    
    //MARK: - Methods
    
    func sendMessage(kind: MessageKind, completion: @escaping OptionalErrorClosure) {
        let senderDocument = firestore.collection(DatabaseCollection.chats)
            .document(sender.id)
            .collection(recipient.id)
            .document()
        
        let recipientDocument = firestore.collection(DatabaseCollection.chats)
            .document(recipient.id)
            .collection(sender.id)
            .document()
        
        var message = String()
        
        switch kind {
        case .text(let string):
            message = string
        default:
            break
        }
        
        let date = Timestamp()
        
        let messageData: [String: Any] = [
            MessageDataFields.senderID: sender.id,
            MessageDataFields.text: message,
            MessageDataFields.date: date
        ]
        
        senderDocument.setData(messageData) { error in
            completion(error)
        }
        
        recipientDocument.setData(messageData) { error in
            completion(error)
        }
        
        persistRecentMessage(with: message, date: date)
    }
    
    func fetchMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        firestore
            .collection(DatabaseCollection.chats)
            .document(sender.id)
            .collection(recipient.id)
            .order(by: MessageDataFields.date)
            .addSnapshotListener { [weak self] querySnapshot, error in
            if let error {
                completion(.failure(error))
                return
            } else {
                guard let self else { return }

                var messages = [Message]()
                
                querySnapshot?.documents.forEach { document in
                    let messageData = document.data()
                    let senderId = messageData[MessageDataFields.senderID] as? String ?? ""
                    
                    let sender = Sender(
                        senderId: senderId,
                        displayName: senderId == self.sender.id ? self.sender.fullName : self.recipient.fullName
                    )
                    
                    let message = Message(
                        sender: sender,
                        messageId: document.documentID,
                        sentDate: (document[MessageDataFields.date] as? Timestamp)?.dateValue() ?? Date(),
                        kind: .text(messageData[MessageDataFields.text] as? String ?? "")
                    )
                    
                    messages.append(message)
                }
                
                completion(.success(messages))
            }
            
        }
    }
}

//MARK: - Private methods

private extension ChatManagerImpl {
    func persistRecentMessage(with message: String, date: Timestamp) {
        persistMessageForSender(message, date: date)
        persistMessageForRecipient(message, date: date)
    }
    
    private func persistMessageForSender(_ message: String, date: Timestamp) {
        let senderDocument = firestore
            .collection(DatabaseCollection.recentChats)
            .document(sender.id)
            .collection(DatabaseCollection.recentChat)
            .document(recipient.id)
        
        let senderData: [String: Any] = [
            ChatDataFields.userId: recipient.id,
            ChatDataFields.userFirstName: recipient.firstName,
            ChatDataFields.userLastName: recipient.lastName ?? "",
            ChatDataFields.userEmail: recipient.email,
            ChatDataFields.profileImage: recipient.profileImageData ?? "",
            ChatDataFields.lastMessage: message,
            ChatDataFields.date: date
        ]
        
        senderDocument.setData(senderData) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    private func persistMessageForRecipient(_ message: String, date: Timestamp) {
        let recipientDocument = firestore
            .collection(DatabaseCollection.recentChats)
            .document(recipient.id)
            .collection(DatabaseCollection.recentChat)
            .document(sender.id)
        
        let recipientData: [String: Any] = [
            ChatDataFields.userId: sender.id,
            ChatDataFields.userFirstName: sender.firstName,
            ChatDataFields.userLastName: sender.lastName ?? "",
            ChatDataFields.userEmail: sender.email,
            ChatDataFields.profileImage: sender.profileImageData ?? "",
            ChatDataFields.lastMessage: message,
            ChatDataFields.date: date
        ]

        recipientDocument.setData(recipientData) { error in
            if let error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
