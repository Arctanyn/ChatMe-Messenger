//
//  Authentication.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import Foundation

protocol Authentication {
    func checkToValid(email: String, password: String) -> LoginError?
}
