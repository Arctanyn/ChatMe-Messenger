//
//  DatabasePathImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Malil Dugulyubgov on 29.10.2022.
//

import Foundation
import FirebaseFirestore

struct DatabasePathImpl: DatabasePath {
    
    //MARK: Properties
    
    var usersCollection: CollectionReference {
        firestore.collection(DatabaseCollection.users)
    }
    
    var chatsCollection: CollectionReference {
        firestore.collection(DatabaseCollection.chats)
    }
    
    var recentChatsCollection: CollectionReference {
        firestore.collection(DatabaseCollection.recentChats)
    }
    
    var singleRecentChatCollection: CollectionReference {
        firestore.collection(DatabaseCollection.recentChat)
    }
    
    private let firestore = Firestore.firestore()
}

//MARK: - Methods

extension DatabasePath {
    
    //MARK: - Users
    
    func getUserDocument(id: String) -> DocumentReference {
        usersCollection.document(id)
    }
    
    //MARK: - Chats
    
    func getChatWithRecipientCollection(currentUserId: String, recipientId: String) -> CollectionReference {
        chatsCollection
            .document(currentUserId)
            .collection(recipientId)
    }
    
    func getChatWithCurrentUserCollection(currentUserId: String, recipientId: String) -> CollectionReference {
        chatsCollection
            .document(recipientId)
            .collection(currentUserId)
    }
    
    func getChatWithRecipientDocument(currentUserId: String, recipientId: String) -> DocumentReference {
        let recipientCollection = getChatWithRecipientCollection(
            currentUserId: currentUserId,
            recipientId: recipientId
        )
        return recipientCollection.document()
    }
    
    func getChatWithCurrentUserDocument(currentUserId: String, recipientId: String) -> DocumentReference {
        let currentUserCollection = getChatWithCurrentUserCollection(
            currentUserId: currentUserId,
            recipientId: recipientId
        )
        return currentUserCollection.document()
    }
    
    //MARK: - Recent Chats
    
    func getRecentChatsCollection(userId: String) -> CollectionReference {
        recentChatsCollection
            .document(userId)
            .collection(DatabaseCollection.recentChat)
    }

    func getRecentChatWithRecipientDocument(currentUserId: String, recipientId: String) -> DocumentReference {
        let recentChats = getRecentChatsCollection(userId: currentUserId)
        return recentChats.document(recipientId)
    }
    
    func getRecentChatWithCurrentUserDocument(currentUserId: String, recipientId: String) -> DocumentReference {
        let recentChats = getRecentChatsCollection(userId: recipientId)
        return recentChats.document(currentUserId)
    }
}
