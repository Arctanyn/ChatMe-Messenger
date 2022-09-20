//
//  ApplicationCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    //MARK: Properties

    private lazy var isLogin = false

    private let authService: AuthService
    private let coordinatorFactory: CoordinatorFactory
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(authService: AuthService,
         coordinatorFactory: CoordinatorFactory,
         assemblyBuilder: AssemblyBuilder,
         router: Router) {
        self.authService = authService
        self.coordinatorFactory = coordinatorFactory
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        if authService.checkUserAvailability() {
            isLogin = true
            runCMFlow()
        } else {
            isLogin = false
            runLoginFlow()
        }
    }
}

//MARK: - Private methods

private extension ApplicationCoordinator {
    func runLoginFlow() {
        let coordinator = coordinatorFactory.createLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.childDidFinish(coordinator)
            self?.start()
        }
        
        addChild(coordinator)
        coordinator.start()
    }
    
    func runCMFlow() {
        let coordinator = coordinatorFactory.createCMCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.childDidFinish(coordinator)
        }
        coordinator.isAlreadyLoggedIn = isLogin
        addChild(coordinator)
        coordinator.start()
    }
}
