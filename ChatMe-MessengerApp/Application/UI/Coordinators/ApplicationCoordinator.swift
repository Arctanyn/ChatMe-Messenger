//
//  ApplicationCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
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
        runOverviewFlow()
    }

    //MARK: - Private methods
    private func runOverviewFlow() {
        let coordinator = setupOverviewCoordinator()
        addChild(coordinator)
        coordinator.start()
    }
    
    private func setupOverviewCoordinator() -> OverviewCoordinator {
        let coordinator = coordinatorFactory.createOverviewCoordinator(router: router)
        coordinator.finishFlow = { [weak self] in
            self?.childDidFinish(coordinator)
        }
        return coordinator
    }
}
