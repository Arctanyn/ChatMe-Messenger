//
//  DatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation
import FirebaseFirestore

final class DatabaseManagerImpl: DatabaseManager {
    private let firestore = Firestore.firestore()

    func addData(_ data: [String : Any],
                 toCollection collection: DatabaseCollection,
                 inDocument document: String,
                 completion: @escaping OptionalErrorClosure) {
        firestore.collection(collection.rawValue).document(document).setData(data) { error in
            completion(error)
        }
    }
}
