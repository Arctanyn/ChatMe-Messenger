//
//  AuthServiceImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 18.09.2022.
//

import Foundation
import FirebaseAuth

final class AuthServiceImpl: AuthService {
    
    //MARK: Properties
    
    private let auth: Auth
    
    //MARK: - Initialization
    
    init() {
        self.auth = Auth.auth()
    }
    
    //MARK: - Methods
    
    var currentUser: User? {
        auth.currentUser
    }
    
    func checkUserAvailability() -> Bool {
        return currentUser != nil
    }
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { [unowned self] authResult, error in
            checkResult(with: authResult, error: error) { result in
                switch result {
                case .success(let authResult):
                    completion(.success(authResult))
                case .failure(let error):
                    completion(.failure(.invalidUserData))
                    print(error)
                }
            }
        }
    }
    
    func signUp(withEmail email: String, password: String, completion: @escaping (Result<AuthDataResult, AuthError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [unowned self] authResult, error in
            checkResult(with: authResult, error: error) { result in
                switch result {
                case .success(let authResult):
                    completion(.success(authResult))
                case .failure(let error):
                    completion(.failure(.failedToCreateNewAccount))
                    print(error)
                }
            }
        }
    }
    
    func signOut(completion: VoidClosure) {
        guard checkUserAvailability() else { return }
        do {
            try auth.signOut()
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }

}

//MARK: - Private methods

private extension AuthServiceImpl {
    func checkResult(with authResult: AuthDataResult?, error: Error?, completion: (Result<AuthDataResult, Error>) -> Void) {
        guard let authResult = authResult, error == nil
        else {
            completion(.failure(error!))
            return
        }
        completion(.success(authResult))
    }
}
