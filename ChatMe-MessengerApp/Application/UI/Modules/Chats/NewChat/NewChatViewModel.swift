//
//  NewChatViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation
import FirebaseAuth

//MARK: - NewChatViewModel

protocol NewChatViewModel {
    func searchUser(query: String, completion: @escaping VoidClosure)
    func createSearchResultsViewModel() -> UsersSearchResultsViewModel
    func closePage()
    func pageDidClose()
}

//MARK: - NewChatViewModelImpl

final class NewChatViewModelImpl: NewChatViewModel {
    
    //MARK: Properties

    private let usersDatabaseManager: UsersDatabaseManager
    private let coordinator: Coordinator
    
    private var users: [UserProfile] = []
    
    //MARK: - Initialization
    
    init(usersDatabaseManager: UsersDatabaseManager, coordinator: Coordinator) {
        self.usersDatabaseManager = usersDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func searchUser(query: String, completion: @escaping VoidClosure) {
        usersDatabaseManager.getUsers(withName: query) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func createSearchResultsViewModel() -> UsersSearchResultsViewModel {
        let filteredUsers = users.filter { $0.id != Auth.auth().currentUser?.uid }
        
        let viewModel = UserSearchResultsViewModelImpl(users: filteredUsers)
        viewModel.userSelected = { [weak self] user in
            self?.goToChat(with: user)
        }

        return viewModel
    }
    
    func pageDidClose() {
        guard let coordinator = coordinator as? NewChatCoordinator else { return }
        coordinator.finishFlow?(nil)
    }
    
    func closePage() {
        guard let coordinator = coordinator as? NewChatCoordinator else { return }
        coordinator.backToChats()
    }
}

//MARK: - Private methods

private extension NewChatViewModelImpl {
    func goToChat(with user: UserProfile) {
        guard let coordinator = coordinator as? NewChatCoordinator else { return }
        coordinator.goToChat(with: user)
    }
}
