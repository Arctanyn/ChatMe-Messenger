//
//  AccountRegisterCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import UIKit

final class AccountRegisterCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    
    private let coordinatorFactory: CoordinatorFactory
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    private let navigationController = CMBaseNavigationController()
    
    //MARK: - Initialization
    
    init(coordinatorFactory: CoordinatorFactory, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        navigationController.setViewControllers([assemblyBuilder.createRegisterModule(coordinator: self)], animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        router.present(navigationController)
    }
    
    func backToLogin() {
        router.dismissModule()
        finishFlow?()
    }
    
    func goToProfileRegisterPage(with user: PiecemealUser) {
        let router = RouterImpl(rootController: navigationController)
        
        let coordinator = coordinatorFactory.createProfileRegisterCoordinator(user: user, router: router)
        coordinator.finishFlow = { [weak self] isUserCreated in
            self?.childDidFinish(coordinator)
            
            if isUserCreated {
                self?.finishFlow?()
            }
        }
        addChild(coordinator)
        coordinator.start()
    }
}
