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
        view.viewModel = LoginViewModelImpl(authService: di.authService, coordinator: coordinator)
        return view
    }
    
    func createRegisterModule(coordinator: Coordinator) -> UIViewController {
        let view = AccountRegisterViewController()
        view.viewModel = AccountRegisterViewModelImpl(user: UserModel(), coordinator: coordinator)
        return view
    }
    
    func createProfileRegistrationProfile(user: UserModel, coordinator: Coordinator) -> UIViewController {
        let view = ProfileRegisterViewController()
        view.viewModel = ProfileRegisterViewModelImpl(
            user: user,
            authService: di.authService,
            usersDatabaseManager: di.usersDatabaseManager,
            coordinator: coordinator
        )
        return view
    }
    
    func createChatsModule(coordinator: Coordinator) -> UIViewController {
        let view = ChatsViewController()
        
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
