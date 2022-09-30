//
//  NewChatViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation

//MARK: - NewChatViewModel

protocol NewChatViewModel {
    func searchUser(query: String, completion: @escaping VoidClosure)
    func createSearchResultsViewModel() -> UsersSearchResultsViewModel
    func goToChat()
    func closePage()
    func pageDidClose()
}

//MARK: - NewChatViewModelImpl

final class NewChatViewModelImpl: NewChatViewModel {
    
    //MARK: Properties

    private let usersDatabaseManager: UsersDatabaseManager
    private let coordinator: Coordinator
    
    private var users: [UserModel] = []
    
    //MARK: - Initialization
    
    init(usersDatabaseManager: UsersDatabaseManager, coordinator: Coordinator) {
        self.usersDatabaseManager = usersDatabaseManager
        self.coordinator = coordinator
    }
    
    //MARK: - Methods
    
    func searchUser(query: String, completion: @escaping VoidClosure) {
        usersDatabaseManager.getUser(withName: query) { [weak self] result in
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
        let usersProfiles = users.map {
            UserProfileModel(
                name: $0.fullName,
                email: $0.email,
                profileImageData: $0.profileImageData
            )
        }
        
        let viewModel = UserSearchResultsViewModelImpl(users: usersProfiles)
        viewModel.userSelectedAtIndex = { [weak self] index in
            self?.goToChat()
        }

        return viewModel
    }
    
    func pageDidClose() {
        guard let coordinator = coordinator as? NewChatCoordinator else { return }
        coordinator.finishFlow?()
    }
    
    func closePage() {
        guard let coordinator = coordinator as? NewChatCoordinator else { return }
        coordinator.backToChats()
    }
    
    func goToChat() {
        closePage()
        print("Chat is here!!!")
    }
}
