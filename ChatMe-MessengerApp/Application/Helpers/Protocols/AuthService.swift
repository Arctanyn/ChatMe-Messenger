//
//  AuthService.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 18.09.2022.
//

import Foundation
import FirebaseAuth

protocol AuthService {
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> Void)
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> Void)
}
