//
//  ChatsDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import MessageKit

final class ChatsDatabaseManagerImpl: ChatsDatabaseManager {
    
    //MARK: Properties
    
    var chats: ObservedObject<[RecentChat]> = ObservedObject(value: [])
    
    private let firestore = Firestore.firestore()
    private let auth = Auth.auth()
    
    //MARK: - Methods
    
    func fetchRecentChats() {
        guard let currentUserId = auth.currentUser?.uid else { return }
        
        firestore
            .collection(DatabaseCollection.recentChats)
            .document(currentUserId)
            .collection(DatabaseCollection.recentChat)
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
                        
                        let recentChat = RecentChat(
                            id: documentId,
                            userId: data[ChatDataFields.userId] as? String ?? "",
                            userFirstName: data[ChatDataFields.userFirstName] as? String ?? "",
                            userEmail: data[ChatDataFields.userEmail] as? String ?? "",
                            userLastName: data[ChatDataFields.userLastName] as? String,
                            profileImageData: data[ChatDataFields.profileImage] as? Data,
                            lastMessage: data[ChatDataFields.lastMessage] as? String ?? "",
                            date: (data[ChatDataFields.date] as? Timestamp)?.dateValue() ?? Date()
                        )
                        
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
                    
                    self.chats.value = recentChats
                }
            }
    }
}

//MARK: - Private methods

private extension ChatsDatabaseManagerImpl {
    
}
