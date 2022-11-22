//
//  MessageKind + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 22.11.2022.
//

import MessageKit

extension MessageKind {
    var toDatabaseKind: MessageDatabaseKind {
        switch self {
        case .photo:
            return .photo
        default:
            return .text
        }
    }
}
