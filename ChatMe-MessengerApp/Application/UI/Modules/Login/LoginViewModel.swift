//
//  LoginViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import Foundation

//MARK: LoginViewModel

protocol LoginViewModel: AuthErrorPresenter {
    func login(withEmail email: String, password: String)
    func showSignUpPage()
    func checkToValid(email: String, password: String) -> LoginError?
}

//MARK: - LoginViewModelImpl

final class LoginViewModelImpl: LoginViewModel {

    //MARK: Properties
    
    var displayError: ((AuthError) -> Void)?
    
    private let authService: AuthService
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(authService: AuthService, coordinator: Coordinator) {
        self.authService = authService
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func login(withEmail email: String, password: String) {
        guard let loginCoordinator = coordinator as? LoginCoordinator else { return }
        
        authService.signIn(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                let user = authResult.user
                print("Welcome back: ", user.email ?? "")
                loginCoordinator.finishFlow?(.signIn)
            case .failure(let authError):
                self?.displayError?(authError)
            }
        }
    }
    
    func showSignUpPage() {
        guard let loginCoordinator = coordinator as? LoginCoordinator else { return }
        loginCoordinator.runRegisterFlow()
    }
    
    func checkToValid(email: String, password: String) -> LoginError? {
        guard !email.isEmpty, !password.isEmpty else { return .emptyField }
        return nil
    }
}

