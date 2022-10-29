//
//  ChatsDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class ChatsDatabaseManagerImpl: ChatsDatabaseManager {
    
    //MARK: Properties
    
    var chats: ObservableObject<[RecentChat]> = ObservableObject(value: [])
    
    private let auth = Auth.auth()
    private let databasePath: DatabasePath
    
    //MARK: - Initialization
    
    init(databasePath: DatabasePath) {
        self.databasePath = databasePath
    }
    
    //MARK: - Methods
    
    func fetchRecentChats() {
        guard let currentUserId = auth.currentUser?.uid else { return }
        databasePath.getRecentChatsCollection(userId: currentUserId)
            .order(by: ChatDataFields.date)
            .addSnapshotListener { [weak self] querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            } else {
                guard let self else { return }
                
                var recentChats = self.chats.value
                
                querySnapshot?.documentChanges.forEach { changedDocument in
                    let documentId = changedDocument.document.documentID
                    let data = changedDocument.document.data()
                    
                    if let userData = data[ChatDataFields.user] as? DatabaseDocumentData {
                        let recentChat = RecentChat(id: documentId, data: data, userData: userData)
                        
                        let index = recentChats.firstIndex(where: { $0.id == documentId })
                        
                        switch changedDocument.type {
                        case .removed:
                            if let index {
                                recentChats.remove(at: index)
                            }
                        default:
                            if let index {
                                recentChats.remove(at: index)
                            }
                            recentChats.insert(recentChat, at: 0)
                        }
                    }
                }
                self.chats.value = recentChats
            }
        }
    }
    
    func deleteChat(withId id: String, recipientId: String) {
        guard let currentUserId = auth.currentUser?.uid else { return }
        
        let chatCollection = databasePath.getChatWithRecipientCollection(
            currentUserId: currentUserId,
            recipientId: recipientId
        )
        
        chatCollection.getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            } else {
                querySnapshot?.documents.forEach { $0.reference.delete() }
            }
        }

        let recentChatDocument = databasePath.getRecentChatWithRecipientDocument(
            currentUserId: currentUserId,
            recipientId: recipientId
        )
        recentChatDocument.delete()
    }
}

