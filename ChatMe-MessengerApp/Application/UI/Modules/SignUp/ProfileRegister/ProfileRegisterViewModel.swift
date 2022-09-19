//
//  ProfileRegisterViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import Foundation

//MARK: - ProfileRegisterViewModel

protocol ProfileRegisterViewModel: AuthErrorPresenter {
    var newAccountDidCreate: VoidClosure? { get set }
    func createNewAccount(withName name: String, lastName: String?, profileImage: Data?, completion: @escaping VoidClosure)
    func backToAccountRegister()
    func checkToValid(username: String, lastName: String?) -> LoginError?
    func completeRegistration()
}

//MARK: - ProfileRegisterViewModelImpl

final class ProfileRegisterViewModelImpl: ProfileRegisterViewModel {
    
    //MARK: Properties
    
    var newAccountDidCreate: VoidClosure?
    var displayError: ((AuthError) -> Void)?

    private var user: PiecemealUser
    private let authService: AuthService
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(user: PiecemealUser, authService: AuthService, coordinator: Coordinator) {
        self.user = user
        self.authService = authService
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func createNewAccount(withName name: String,
                          lastName: String?,
                          profileImage: Data?,
                          completion: @escaping VoidClosure) {
        user.name = name
        user.lastName = lastName
        user.profileImageData = profileImage
        
        guard let email = user.email,
              let password = user.password
        else { return }
        
        authService.signUp(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success(let authResult):
                completion()
                print("Created new user:", authResult.user)
                self?.newAccountDidCreate?()
            case .failure(let authError):
                completion()
                self?.displayError?(authError)
            }
        }
    }
    
    
    func completeRegistration() {
        guard let coordinator = coordinator as? ProfileRegisterCoordinator else { return }
        coordinator.showLoginPage()
    }
    
    func backToAccountRegister() {
        guard let coordinator = coordinator as? ProfileRegisterCoordinator else { return }
        coordinator.backToAccountRegister()
    }
    
    func checkToValid(username: String, lastName: String?) -> LoginError? {
        guard !username.isEmpty else { return .missingName }

        return nil
    }
}
