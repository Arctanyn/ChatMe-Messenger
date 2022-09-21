//
//  LoginCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    
    enum AuthMethod {
        case signIn
        case signUp
    }
    
    //MARK: Properties
    
    var finishFlow: ((AuthMethod) -> Void)?
    
    private let coordinatorsFactory: CoordinatorFactory
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(coordinatorsFactory: CoordinatorFactory, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.coordinatorsFactory = coordinatorsFactory
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        let module = assemblyBuilder.createLoginModule(coordinator: self)
        router.setRootModule(module, hideBar: true)
    }
    
    func runRegisterFlow() {
        let coordinator = coordinatorsFactory.createRegisterCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.childDidFinish(coordinator)
            self?.finishFlow?(.signUp)
        }
        addChild(coordinator)
        coordinator.start()
    }
}
