//
//  DatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation
import FirebaseFirestore

protocol DatabaseManager {
    func addData(_ data: [String: Any], toCollection collection: DatabaseCollection, inDocument document: String, completion: @escaping OptionalErrorClosure)
    func getData(fromCollection collection: DatabaseCollection, inDocument document: String, completion: @escaping (Result<[String: Any], Error>) -> Void)
    func getDocuments(fromCollection: DatabaseCollection, completion: @escaping (Result<[QueryDocumentSnapshot], Error>) -> Void)
}
