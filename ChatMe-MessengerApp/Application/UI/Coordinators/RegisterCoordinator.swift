//
//  RegisterCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import UIKit

final class RegisterCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(assemblyBuilder: AssemblyBuilder, router: Router) {
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        let navigationController = CMBaseNavigationController(
            rootViewController: assemblyBuilder.createRegisterModule(coordinator: self)
        )
        navigationController.modalPresentationStyle = .fullScreen
        
        router.present(navigationController)
    }
    
    func backToLogin() {
        router.dismissModule()
        finishFlow?()
    }
}
