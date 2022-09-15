//
//  RegisterViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import Foundation

protocol RegisterViewModel {
    func signUp()
    func backToLogin()
}

final class RegisterViewModelImpl: RegisterViewModel {
    
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func signUp() {
        
    }
    
    func backToLogin() {
        guard let coordinator = coordinator as? RegisterCoordinator else { return }
        coordinator.backToLogin()
    }
}
