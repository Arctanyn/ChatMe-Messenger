//
//  AccountRegisterViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import Foundation

//MARK: - AccountRegisterViewModel

protocol AccountRegisterViewModel {
    func backToLogin()
    func showProfileRegistrationPage(withEmailAdress email: String, password: String)
    func checkToValid(email: String, password: String, repeatedPassword: String) -> LoginError?
}

//MARK: - AccountRegisterViewModelImpl

final class AccountRegisterViewModelImpl: AccountRegisterViewModel {

    //MARK: Properties
    
    private var user: UserModel
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(user: UserModel, coordinator: Coordinator) {
        self.user = user
        self.coordinator = coordinator
    }
    
    func showProfileRegistrationPage(withEmailAdress email: String, password: String) {
        guard let coordinator = coordinator as? AccountRegisterCoordinator else { return }
        
        user.email = email
        user.password = password
        
        coordinator.goToProfileRegisterPage(with: user)
    }
    
    func backToLogin() {
        guard let coordinator = coordinator as? AccountRegisterCoordinator else { return }
        coordinator.backToLogin()
    }
    
    func checkToValid(email: String, password: String, repeatedPassword: String) -> LoginError? {
        guard !email.isEmpty, !password.isEmpty else { return .emptyField }
        guard email.isValidEmail() else { return .invalidEmail }
        
        if let passwordError = checkPasswordToValid(with: password, repeatedPassword: repeatedPassword) {
            return passwordError
        }
        
        return nil
    }
}

private extension AccountRegisterViewModelImpl {
    func checkPasswordToValid(with password: String, repeatedPassword: String?) -> LoginError? {
        if password != repeatedPassword {
            return .differentPasswords
        }
        
        if password.count < 6 {
            return .shortPassword
        }
        
        return nil
    }
}
