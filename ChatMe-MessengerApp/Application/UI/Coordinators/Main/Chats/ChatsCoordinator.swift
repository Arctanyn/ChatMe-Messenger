//
//  ChatsCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import Foundation

final class ChatsCoordinator: BaseCoordinator {
    
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
        let module = assemblyBuilder.createChatsModule(coordinator: self)
        router.setRootModule(module)
    }
    
    func runStartNewChatFlow() {
        let coordinator = coordinatorFactory.createNewChatCoordinator(router: router)
        coordinator.finishFlow = { [weak self] user in
            if let user {
                self?.goToChat(with: user)
            }
            self?.childDidFinish(coordinator)
        }
        addChild(coordinator)
        coordinator.start()
        
    }
    
    func goToChat(with user: UserProfile) {
        let coordinator = coordinatorFactory.createChatCoordinator(user: user, router: router)
        coordinator.finishFlow = { [weak self] in
            self?.childDidFinish(coordinator)
        }
        coordinator.start()
    }
}
