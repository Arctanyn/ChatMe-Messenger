//
//  DatabasePath.swift
//  ChatMe-MessengerApp
//
//  Created by Malil Dugulyubgov on 29.10.2022.
//

import Foundation
import FirebaseFirestore

protocol DatabasePath {
    var usersCollection: CollectionReference { get }
    var chatsCollection: CollectionReference { get }
    var recentChatsCollection: CollectionReference { get }
    
    func getUserDocument(id: String) -> DocumentReference
    
    func getChatWithRecipientCollection(currentUserId: String, recipientId: String) -> CollectionReference
    func getChatWithCurrentUserCollection(currentUserId: String, recipientId: String) -> CollectionReference
    func getChatWithRecipientDocument(currentUserId: String, recipientId: String) -> DocumentReference
    func getChatWithCurrentUserDocument(currentUserId: String, recipientId: String) -> DocumentReference
    
    func getRecentChatsCollection(userId: String) -> CollectionReference
    func getRecentChatWithRecipientDocument(currentUserId: String, recipientId: String) -> DocumentReference
    func getRecentChatWithCurrentUserDocument(currentUserId: String, recipientId: String) -> DocumentReference
}
