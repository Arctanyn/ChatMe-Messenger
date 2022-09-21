//
//  UserCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import Foundation

final class UserCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    
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
        let viewController = assemblyBuilder.createUserModule(coordinator: self)
        router.setRootModule(viewController)
    }
}
