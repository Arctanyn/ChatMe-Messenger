//
//  AssemblyBuilderImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import UIKit

final class AssemblyBuilderImpl: AssemblyBuilder {
    
    //MARK: Properties
    
    weak var di: DI!
    
    //MARK: - Methods

    func createLoginModule(coordinator: Coordinator) -> UIViewController {
        let view = LoginViewController()
        view.viewModel = LoginViewModelImpl(
            authService: di.authService,
            usersDatabaseManager: di.usersDatabaseManager,
            coordinator: coordinator
        )
        return view
    }
    
    func createRegisterModule(coordinator: Coordinator) -> UIViewController {
        let view = AccountRegisterViewController()
        view.viewModel = AccountRegisterViewModelImpl(user: PiecemealUser(), coordinator: coordinator)
        return view
    }
    
    func createProfileRegistrationProfile(user: PiecemealUser, coordinator: Coordinator) -> UIViewController {
        let view = ProfileRegisterViewController()
        view.viewModel = ProfileRegisterViewModelImpl(
            user: user,
            authService: di.authService,
            usersDatabaseManager: di.usersDatabaseManager,
            coordinator: coordinator
        )
        return view
    }
    
    func createChatsListModule(coordinator: Coordinator) -> UIViewController {
        let view = ChatsListViewController()
        view.viewModel = ChatsListViewModelImpl(
            chatsDatabaseManager: di.chatsDatabaseManager,
            coordinator: coordinator
        )
        return view
    }
    
    func createChatModule(with otherUser: UserProfile, coordinator: Coordinator) -> UIViewController {
        guard let currentUser = UserDefaults.standard.getCurrentUser() else {
            fatalError("The user does not exist")
        }
        
        let view = ChatViewController()
        
        view.viewModel = ChatViewModelImpl(
            currentUser: currentUser,
            recipient: otherUser,
            chatManager: ChatManagerImpl(
                sender: currentUser,
                recipient: otherUser,
                chatsDatabaseManager: di.chatsDatabaseManager,
                databasePath: di.databasePath
            ),
            coordinator: coordinator
        )
        
        return view
    }
    
    func createNewChatModule(coordinator: Coordinator) -> UIViewController {
        let view = NewChatViewController()
        view.viewModel = NewChatViewModelImpl(
            usersDatabaseManager: di.usersDatabaseManager,
            coordinator: coordinator
        )
        return view
    }
    
    func createUserModule(coordinator: Coordinator) -> UIViewController {
        let view = UserViewController()
        view.viewModel = UserViewModelImpl(
            usersDatabaseManager: di.usersDatabaseManager,
            authService: di.authService,
            coordinator: coordinator
        )
        return view
    }
}
