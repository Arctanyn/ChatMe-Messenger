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
    func createNewAccount(withName name: String, lastName: String?, profileImage: Data?)
    func backToAccountRegister()
    func checkToValid(firstName: String, lastName: String?) -> LoginError?
    func completeRegistration()
}

//MARK: - ProfileRegisterViewModelImpl

final class ProfileRegisterViewModelImpl: ProfileRegisterViewModel {
    
    //MARK: Properties
    
    var newAccountDidCreate: VoidClosure?
    var displayError: ((AuthError) -> Void)?

    private var user: PiecemealUser
    private let authService: AuthService
    private let usersDatabaseManager: UsersDatabaseManager
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(user: PiecemealUser,
         authService: AuthService,
         usersDatabaseManager: UsersDatabaseManager,
         coordinator: Coordinator) {
        self.user = user
        self.authService = authService
        self.usersDatabaseManager = usersDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func createNewAccount(withName name: String, lastName: String?, profileImage: Data?) {
        user.firstName = name
        user.lastName = lastName
        user.profileImageData = profileImage

        authService.signUp(withEmail: user.email, password: user.password) { [weak self] result in
            guard let self = self else {
                self?.displayError?(.failedToCreateNewAccount)
                return
            }
            switch result {
            case .success(let authResult):
                let userId = authResult.user.uid
                
                self.usersDatabaseManager.addUser(withData: self.user, userIdentifier: userId) { error in
                    guard error == nil else {
                        self.displayError?(.failedToCreateNewAccount)
                        return
                    }
                    
                    let userProfile = UserProfile(
                        id: userId,
                        firstName: self.user.firstName,
                        lastName: self.user.lastName,
                        email: self.user.email,
                        profileImageData: self.user.profileImageData
                    )
                    
                    UserDefaults.standard.addUser(userProfile)
                    
                    self.newAccountDidCreate?()
                }
            case .failure(let authError):
                self.displayError?(authError)
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
    
    func checkToValid(firstName: String, lastName: String?) -> LoginError? {
        guard !firstName.isEmpty else { return .missingName }

        return nil
    }
}
