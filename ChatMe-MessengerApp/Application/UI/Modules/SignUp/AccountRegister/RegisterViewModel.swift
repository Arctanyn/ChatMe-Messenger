//
//  RegisterViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import Foundation

//MARK: - RegisterViewModel

protocol RegisterViewModel {
    func backToLogin()
    func showProfileRegistrationPage(withEmailAdress email: String, password: String)
    func checkToValid(email: String, password: String, repeatedPassword: String) -> LoginError?
}

//MARK: - RegisterViewModelImpl

final class RegisterViewModelImpl: RegisterViewModel {

    //MARK: Properties
    
    private var user: User
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(user: User, coordinator: Coordinator) {
        self.user = user
        self.coordinator = coordinator
    }
    
    func showProfileRegistrationPage(withEmailAdress email: String, password: String) {
        guard let coordinator = coordinator as? RegisterCoordinator else { return }
        
        user.email = email
        user.password = password
        
        coordinator.goToProfileRegisterPage(with: user)
    }
    
    func backToLogin() {
        guard let coordinator = coordinator as? RegisterCoordinator else { return }
        coordinator.backToLogin(isUserCreated: false)
    }
    
    func checkToValid(email: String, password: String, repeatedPassword: String) -> LoginError? {
        guard !email.isEmpty, !password.isEmpty else { return .emptyField }
        
        if password != repeatedPassword {
            return .differentPasswords
        }
        
        return nil
    }
}
