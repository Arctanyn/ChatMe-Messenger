//
//  ChatManager.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 02.10.2022.
//

import Foundation
import MessageKit

protocol ChatManager {
    func sendMessage(kind: MessageKind, completion: @escaping OptionalErrorClosure)
    func fetchMessages(completion: @escaping (Result<[Message], Error>) -> Void)
}
