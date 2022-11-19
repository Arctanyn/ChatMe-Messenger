//
//  CMCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

final class CMCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    var isAlreadyLoggedIn = false
    
    private let mainTabBarController = CMTabBarController()
    private var navigationControllers: [CMBaseNavigationController] = []
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactory
    private let assemblyBuilder: AssemblyBuilder
    
    //MARK: - Initialization
    
    init(coordinatorFactory: CoordinatorFactory, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.coordinatorFactory = coordinatorFactory
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        prepareTabs()

        mainTabBarController.configureViewControllers(with: navigationControllers)

        mainTabBarController.modalPresentationStyle = .fullScreen
        
        if isAlreadyLoggedIn {
            mainTabBarController.modalTransitionStyle = .flipHorizontal
        }
        
        router.present(mainTabBarController, animated: isAlreadyLoggedIn)
    }
}

//MARK: - Private methods

private extension CMCoordinator {
    func prepareTabs() {
        Tabs.allCases.forEach { setupCoordinator(for: $0) }
        childCoordinators.forEach { $0.start() }
    }
    
    func setupCoordinator(for tab: Tabs) {
        let navController = CMBaseNavigationController()
        navController.tabBarItem.tag = tab.rawValue
        navigationControllers.append(navController)
        
        let router = RouterImpl(rootController: navController)

        switch tab {
        case .chats:
            let coordinator = coordinatorFactory.createChatsListCoordinator(router: router)
            coordinator.finishFlow = { [weak self] in
                self?.childDidFinish(coordinator)
            }
            addChild(coordinator)
        case .user:
            let coordinator = coordinatorFactory.createUserCoordinator(router: router)
            coordinator.finishFlow = { [weak self] in
                self?.childCoordinators.removeAll()
                self?.mainTabBarController.modalTransitionStyle = .flipHorizontal
                self?.router.dismissModule()
                self?.finishFlow?()
            }
            addChild(coordinator)
        }
    }
}
