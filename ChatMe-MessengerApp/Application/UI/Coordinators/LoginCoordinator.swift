//
//  LoginCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    
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
        let viewController = assemblyBuilder.createLoginModule(coordinator: self)
        router.setRootModule(viewController, hideBar: true)
    }
}
