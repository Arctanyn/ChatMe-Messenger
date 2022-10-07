//
//  Message.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 07.10.2022.
//

import Foundation
import MessageKit

struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}
