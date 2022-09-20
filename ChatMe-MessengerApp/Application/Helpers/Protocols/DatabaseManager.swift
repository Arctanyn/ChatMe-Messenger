//
//  DatabaseManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

protocol DatabaseManager {
    func addData(_ data: [String: Any], toCollection collection: DatabaseCollection, inDocument document: String, completion: @escaping OptionalErrorClosure)
}
