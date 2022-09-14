//
//  CMCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

final class CMCoordinator: BaseCoordinator {
    
    var finishFlow: VoidClosure?
    var isAlreadyLoggedIn = false
    
    private var tabs: [Tabs: UINavigationController] = [:]
    
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
        
        let mainTabBarController = CMTabBarController()
        mainTabBarController.configureViewControllers(with: tabs)

        mainTabBarController.modalPresentationStyle = .fullScreen
        
        if !isAlreadyLoggedIn {
            mainTabBarController.modalTransitionStyle = .flipHorizontal
        }
        
        router.present(mainTabBarController, animated: !isAlreadyLoggedIn)
    }
}

//MARK: - Private methods

private extension CMCoordinator {
    func prepareTabs() {
        Tabs.allCases.forEach { setupCoordinator(for: $0) }
        childCoordinators.forEach { $0.start() }
    }
    
    func setupCoordinator(for tab: Tabs) {
        let navController = UINavigationController()
        tabs[tab] = navController
        
        let router = RouterImpl(rootController: navController)
        
        var coordinator: Coordinator!
        
        switch tab {
        case .chats:
            coordinator = coordinatorFactory.createChatsCoordinator(router: router)
        case .user:
            coordinator = coordinatorFactory.createUserCoordinator(router: router)
        }
        
        addChild(coordinator)
    }
}
