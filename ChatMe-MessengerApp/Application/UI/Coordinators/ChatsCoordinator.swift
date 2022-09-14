//
//  ChatsCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import Foundation

final class ChatsCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
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
        let viewController = assemblyBuilder.createChatsModule(coordinator: self)
        router.setRootModule(viewController)
    }
}
