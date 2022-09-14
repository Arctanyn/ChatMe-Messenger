//
//  ApplicationCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    private var isLogin = true
    
    private let coordinatorFactory: CoordinatorFactory
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(coordinatorFactory: CoordinatorFactory, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        if isLogin {
            runCMFlow()
        } else {
            runLoginFlow()
        }
    }
}

//MARK: - Private methods

private extension ApplicationCoordinator {
    func runLoginFlow() {
        let coordinator = coordinatorFactory.createLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.runCMFlow()
            self?.isLogin = true
            self?.childDidFinish(coordinator)
            self?.start()
        }
        
        addChild(coordinator)
        coordinator.start()
    }
    
    func runCMFlow() {
        let coordinator = coordinatorFactory.createCMCoordinator(router: router)
        coordinator.isAlreadyLoggedIn = isLogin
        addChild(coordinator)
        coordinator.start()
    }
}
