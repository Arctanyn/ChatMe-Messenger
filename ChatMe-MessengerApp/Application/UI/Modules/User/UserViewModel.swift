//
//  UserViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

//MARK: UserViewModel

protocol UserViewModel {
    var fullName: String { get }
    var email: String { get }
    var profileImageData: Data? { get }
    func fetchUser(completion: @escaping VoidClosure)
    func logOut()
}

//MARK: - UserViewModelImpl

final class UserViewModelImpl: UserViewModel {

    
    //MARK: Properties

    var fullName: String {
        user?.fullName ?? ""
    }
    
    var email: String {
        user?.email ?? ""
    }
    
    var profileImageData: Data? {
        user?.profileImageData
    }
    
    private var user: UserModel?
    private let usersDatabaseManager: UsersDatabaseManager
    private let authService: AuthService
    private let coordinator: Coordinator
    
    //MARK: - Initialization
    
    init(usersDatabaseManager: UsersDatabaseManager, authService: AuthService, coordinator: Coordinator) {
        self.usersDatabaseManager = usersDatabaseManager
        self.authService = authService
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func fetchUser(completion: @escaping VoidClosure) {
        guard let user = authService.currentUser else { return }
        usersDatabaseManager.getUser(withID: user.uid) { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func logOut() {
        guard let coordinator = coordinator as? UserCoordinator else { return }
        authService.signOut {
            coordinator.finishFlow?()
        }
    }
    
}
