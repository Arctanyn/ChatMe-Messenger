//
//  DatabaseManagerImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation
import FirebaseFirestore

final class DatabaseManagerImpl: DatabaseManager {
    
    //MARK: Properties
    
    private let firestore: Firestore
    
    //MARK: - Initialization
    
    init() {
        firestore = Firestore.firestore()
    }

    //MARK: - Methods

    func addData(_ data: [String : Any],
                 toCollection collection: DatabaseCollection,
                 inDocument document: String,
                 completion: @escaping OptionalErrorClosure) {
        firestore.collection(collection.rawValue).document(document).setData(data) { error in
            completion(error)
        }
    }
    
    func getData(fromCollection collection: DatabaseCollection,
                 inDocument document: String,
                 completion: @escaping (Result<[String: Any], Error>) -> Void) {
        firestore.collection(collection.rawValue).document(document).getDocument { snapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard
                let document = snapshot,
                document.exists,
                let data = document.data()
            else {
                return
            }
            
            completion(.success(data))
        }
    }
    
    func getDocuments(fromCollection: DatabaseCollection,
                      completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void) {
        firestore.collection(fromCollection.rawValue).getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let documents = snapshot?.documents else {
                return
            }
            
            completion(.success(documents))
        }
    }
}
