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
        
        setData(messageData, inDocument: senderDocument) { error in
            completion(error)
        }
        
        setData(messageData, inDocument: recipientDocument)
        
        persistRecentMessage(with: message, date: date)
    }
    
    func fetchMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        let chatsCollection = firestore.collection(DatabaseCollection.chats)
        
        chatsCollection
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
    
    func persistMessageForSender(_ message: String, date: Timestamp) {
        let senderDocument = firestore
            .collection(DatabaseCollection.recentChats)
            .document(sender.id)
            .collection(DatabaseCollection.recentChat)
            .document(recipient.id)

        let chatData = setupChatData(withMessage: message, date: date, for: .sender)
        setData(chatData, inDocument: senderDocument)
    }
    
    func persistMessageForRecipient(_ message: String, date: Timestamp) {
        let recipientDocument = firestore
            .collection(DatabaseCollection.recentChats)
            .document(recipient.id)
            .collection(DatabaseCollection.recentChat)
            .document(sender.id)

        let chatData = setupChatData(withMessage: message, date: date, for: .recipient)
        setData(chatData, inDocument: recipientDocument)
    }
    
    func setupChatData(withMessage message: String, date: Timestamp, for userType: ChatUserType) -> [String: Any] {
        let data: [String: Any] = [
            ChatDataFields.lastMessage: message,
            ChatDataFields.date: date,
            ChatDataFields.user: [
                ChatDataFields.userId: userType == .sender ? recipient.id : sender.id,
                ChatDataFields.userFirstName: userType == .sender ? recipient.firstName : sender.firstName,
                ChatDataFields.userLastName: userType == .sender ? recipient.lastName as Any : sender.lastName as Any,
                ChatDataFields.userEmail: userType == .sender ? recipient.email : sender.email,
                ChatDataFields.profileImage: userType == .sender ? recipient.profileImageData as Any : sender.profileImageData as Any
            ]
        ]
    
        return data
    }
    
    func setData(_ data: [String: Any], inDocument document: DocumentReference, completion: ((Error?) -> Void)? = nil) {
        document.setData(data) { error in
            completion?(error)
        }
    }
}
