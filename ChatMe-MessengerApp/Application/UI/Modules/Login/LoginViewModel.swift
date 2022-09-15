//
//  LoginViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import Foundation

//MARK: LoginViewModel

protocol LoginViewModel: Authentication {
    func login()
    func showSingUpPage()
}

//MARK: - LoginViewModelImpl

final class LoginViewModelImpl: LoginViewModel {
    
    //MARK: Properties
    
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func login() {
        guard let loginCoordinator = coordinator as? LoginCoordinator else { return }
        loginCoordinator.finishFlow?()
    }
    
    func showSingUpPage() {
        guard let loginCoordinator = coordinator as? LoginCoordinator else { return }
        loginCoordinator.runRegisterFlow()
    }
    
    func checkToValid(email: String, password: String) -> LoginError? {
        guard !email.isEmpty, !password.isEmpty else { return .emptyField }
        return nil
    }
}
