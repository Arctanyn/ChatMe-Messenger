//
//  ChatsDatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 01.10.2022.
//

import Foundation
import FirebaseFirestore

final class ChatsDatabaseManagerImpl: ChatsDatabaseManager {
    
    //MARK: Properties
    
    var chats: ObservedObject<[RecentChat]> = ObservedObject(value: [])
    
    private let firestore = Firestore.firestore()
    private lazy var currentUser = UserDefaults.standard.getCurrentUser()
    
    //MARK: - Methods
    
    func fetchRecentChats() {
        guard let currentUserId = currentUser?.id else { return }
        
        firestore
            .collection(DatabaseCollection.recentChats)
            .document(currentUserId)
            .collection(DatabaseCollection.recentChat)
            .order(by: ChatDataFields.date)
            .addSnapshotListener({ [weak self] querySnapshot, error in
                if let error {
                    print(error.localizedDescription)
                    return
                } else {
                    guard let self else { return }
                    
                    var recentChats = self.chats.value
                    
                    querySnapshot?.documentChanges.forEach { changedDocument in
                        let documentId = changedDocument.document.documentID
                        let data = changedDocument.document.data()
                        
                        if let recentChat = self.setupRecentChat(with: documentId, from: data) {
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
                
            })
    }
    
    func deleteChat(withId id: String, recipientId: String) {
        guard let currentUserId = currentUser?.id else { return }
                
        firestore.collection(DatabaseCollection.chats).document(currentUserId).collection(recipientId).getDocuments { querySnapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            } else {
                querySnapshot?.documents.forEach { $0.reference.delete() }
            }
        }
        
        firestore.collection(DatabaseCollection.recentChats).document(currentUserId).collection(DatabaseCollection.recentChat).document(recipientId).delete()
    }
}

//MARK: - Private methods

private extension ChatsDatabaseManagerImpl {
    func setupRecentChat(with id: String, from data: [String: Any]) -> RecentChat? {
        guard let user = data[ChatDataFields.user] as? [String: Any] else { return nil }
        let recentChat = RecentChat(
            id: id,
            user: UserProfile(
                id: user[ChatDataFields.userId] as? String ?? "",
                firstName: user[ChatDataFields.userFirstName] as? String ?? "",
                lastName: user[ChatDataFields.userLastName] as? String,
                email: user[ChatDataFields.userEmail] as? String ?? "",
                profileImageData: user[ChatDataFields.profileImage] as? Data
            ),
            lastMessage: data[ChatDataFields.lastMessage] as? String ?? "",
            date: (data[ChatDataFields.date] as? Timestamp)?.dateValue() ?? Date()
        )
        return recentChat
    }
}
