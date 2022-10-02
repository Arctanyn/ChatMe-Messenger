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
        
        switch kind {
        case .text(let string):
            let messageData: [String: Any] = [
                MessageDataFields.senderID: sender.id,
                MessageDataFields.text: string,
                MessageDataFields.date: Timestamp()
            ]
            
            senderDocument.setData(messageData) { error in
                completion(error)
            }
            
            recipientDocument.setData(messageData) { error in
                completion(error)
            }
        default:
            break
        }
    }
    
    func fetchMessages(completion: @escaping (Result<[Message], Error>) -> Void) {
        firestore.collection(DatabaseCollection.chats)
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
