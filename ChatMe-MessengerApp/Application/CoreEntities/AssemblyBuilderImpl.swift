//
//  AssemblyBuilderImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 12.09.2022.
//

import UIKit

final class AssemblyBuilderImpl: AssemblyBuilder {
    weak var di: DI?

    func createLoginModule(coordinator: Coordinator) -> UIViewController {
        let view = LoginController()
        
        let viewModel = LoginViewModelImpl(coordinator: coordinator)
        view.configure(viewModel: viewModel)
        
        return view
    }
    
    func createChatsModule(coordinator: Coordinator) -> UIViewController {
        let view = ChatsController()
        
        return view
    }
    
    func createUserModule(coordinator: Coordinator) -> UIViewController {
        let view = UserController()
        
        return view
    }
}
