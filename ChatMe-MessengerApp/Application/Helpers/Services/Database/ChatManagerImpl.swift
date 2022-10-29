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
    
    enum ChatUserType {
        case sender
        case recipient
    }
    
    //MARK: Properties
    
    private let sender: UserProfile
    private let recipient: UserProfile
    private let chatsDatabaseManager: ChatsDatabaseManager
    private let databasePath: DatabasePath
    
    //MARK: - Initialization
    
    init(sender: UserProfile,
         recipient: UserProfile,
         chatsDatabaseManager: ChatsDatabaseManager,
         databasePath: DatabasePath) {
        self.sender = sender
        self.recipient = recipient
        self.chatsDatabaseManager = chatsDatabaseManager
        self.databasePath = databasePath
    }
    
    //MARK: - Methods
    
    func sendMessage(kind: MessageKind, completion: @escaping OptionalErrorClosure) {
        let date = Timestamp()
        
        let message = createMessage(kind: kind)
        let messageData = createMessageData(withMessage: message, date: date)
        
        let senderDocument = databasePath.getChatWithRecipientDocument(
            currentUserId: sender.id,
            recipientId: recipient.id
        )
        
        let recipientDocument = databasePath.getChatWithCurrentUserDocument(
            currentUserId: sender.id,
            recipientId: recipient.id
        )
        
        setData(messageData, inDocument: senderDocument) { [weak self] error in
            guard error == nil else {
                completion(ChatDatabaseError.failedToSendMessage)
                return
            }
            self?.setData(messageData, inDocument: recipientDocument)
            self?.persistRecentMessage(with: message, date: date)
            completion(nil)
        }
    }
    
    func fetchMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        let chatCollection = databasePath.getChatWithRecipientCollection(
            currentUserId: sender.id,
            recipientId: recipient.id
        )
        
        let sortedChatCollection = chatCollection.order(by: MessageDataFields.date)
        
        sortedChatCollection.addSnapshotListener { [weak self] querySnapshot, error in
            guard error == nil else {
                completion(.failure(ChatDatabaseError.failledToRecieveMessages))
                return
            }
            
            guard let self else {
                completion(.failure(ChatDatabaseError.failledToRecieveMessages))
                return
            }
            
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

//MARK: - Private methods

private extension ChatManagerImpl {
    func createMessage(kind: MessageKind) -> String {
        var message = String()
        
        switch kind {
        case .text(let string):
            message = string
        default:
            break
        }
        
        return message
    }
    
    func createMessageData(withMessage message: String, date: Timestamp) -> DatabaseDocumentData {
        let messageData: DatabaseDocumentData = [
            MessageDataFields.senderID: sender.id,
            MessageDataFields.text: message,
            MessageDataFields.date: date
        ]
        return messageData
    }
    
    func persistRecentMessage(with message: String, date: Timestamp) {
        persistMessageForSender(message, date: date)
        persistMessageForRecipient(message, date: date)
    }
    
    func persistMessageForSender(_ message: String, date: Timestamp) {
        let senderDocument = databasePath.getRecentChatWithRecipientDocument(
            currentUserId: sender.id,
            recipientId: recipient.id
        )
        
        let chatData = setupChatData(withMessage: message, date: date, for: .sender)
        setData(chatData, inDocument: senderDocument)
    }
    
    func persistMessageForRecipient(_ message: String, date: Timestamp) {
        let recipientDocument = databasePath.getRecentChatWithCurrentUserDocument(
            currentUserId: sender.id,
            recipientId: recipient.id
        )
        
        let chatData = setupChatData(withMessage: message, date: date, for: .recipient)
        setData(chatData, inDocument: recipientDocument)
    }
    
    func setupChatData(withMessage message: String, date: Timestamp, for userType: ChatUserType) -> DatabaseDocumentData {
        let data: DatabaseDocumentData = [
            ChatDataFields.lastMessage: message,
            ChatDataFields.date: date,
            ChatDataFields.user: [
                UserDataFields.id: userType == .sender ? recipient.id : sender.id,
                UserDataFields.firstName: userType == .sender ? recipient.firstName : sender.firstName,
                UserDataFields.lastName: userType == .sender ? recipient.lastName as Any : sender.lastName as Any,
                UserDataFields.email: userType == .sender ? recipient.email : sender.email,
                UserDataFields.profileImage: userType == .sender ? recipient.profileImageData as Any : sender.profileImageData as Any
            ]
        ]
        
        return data
    }
    
    func setData(_ data: DatabaseDocumentData, inDocument document: DocumentReference, completion: ((Error?) -> Void)? = nil) {
        document.setData(data) { error in
            completion?(error)
        }
    }
}
