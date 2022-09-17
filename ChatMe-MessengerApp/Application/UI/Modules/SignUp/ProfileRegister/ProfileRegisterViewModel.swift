//
//  ProfileRegisterViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import Foundation

//MARK: - ProfileRegisterViewModel

protocol ProfileRegisterViewModel {
    func createNewAccount(withName name: String, lastName: String?, profileImage: Data?)
    func backToAccountRegister()
    func checkToValid(username: String, lastName: String?) -> LoginError?
}

//MARK: - ProfileRegisterViewModelImpl

final class ProfileRegisterViewModelImpl: ProfileRegisterViewModel {
    
    //MARK: Properties
    
    private var user: User
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(user: User, coordinator: Coordinator) {
        self.user = user
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func createNewAccount(withName name: String, lastName: String?, profileImage: Data?) {
        guard let coordinator = coordinator as? ProfileRegisterCoordinator else { return }
        
        user.name = name
        user.lastName = lastName
        user.profileImageData = profileImage
        
        coordinator.runMainFlow()
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
