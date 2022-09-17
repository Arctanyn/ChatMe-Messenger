//
//  AssemblyBuilderImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import UIKit

final class AssemblyBuilderImpl: AssemblyBuilder {
    
    //MARK: Properties
    
    weak var di: DI?
    
    //MARK: - Methods

    func createLoginModule(coordinator: Coordinator) -> UIViewController {
        let view = LoginViewController()
        view.viewModel = LoginViewModelImpl(coordinator: coordinator)
        return view
    }
    
    func createRegisterModule(coordinator: Coordinator) -> UIViewController {
        let view = RegisterViewController()
        view.viewModel = RegisterViewModelImpl(user: User(), coordinator: coordinator)
        return view
    }
    
    func createProfileRegistrationProfile(user: User, coordinator: Coordinator) -> UIViewController {
        let view = ProfileRegisterViewController()
        view.viewModel = ProfileRegisterViewModelImpl(user: user, coordinator: coordinator)
        return view
    }
    
    func createChatsModule(coordinator: Coordinator) -> UIViewController {
        let view = ChatsViewController()
        
        return view
    }
    
    func createUserModule(coordinator: Coordinator) -> UIViewController {
        let view = UserViewController()
        
        return view
    }
}
