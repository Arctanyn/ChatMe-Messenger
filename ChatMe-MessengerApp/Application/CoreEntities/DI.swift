//
//  DI.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class DI {
    fileprivate let assemblyBuilder: AssemblyBuilderImpl
    fileprivate let coordinatorsFactory: CoordinatorFactoryImpl
    private(set) var authService: AuthService
    private(set) var usersDatabaseManager: UsersDatabaseManager
    private(set) var chatsDatabaseManager: ChatsDatabaseManager
    
    init() {
        assemblyBuilder = AssemblyBuilderImpl()
        coordinatorsFactory = CoordinatorFactoryImpl(assemblyBuilder: assemblyBuilder)
        authService = AuthServiceImpl()
        usersDatabaseManager = UsersDatabaseManagerImpl()
        chatsDatabaseManager = ChatsDatabaseManagerImpl()

        assemblyBuilder.di = self
    }
}

extension DI: AppFactory {
    func makeKeyWindowAndCoordinator(with windowScene: UIWindowScene) -> (UIWindow, Coordinator) {
        let rootNavController = CMBaseNavigationController()
        let router = RouterImpl(rootController: rootNavController)

        let window = UIWindow(windowScene: windowScene)
        let coordinator = coordinatorsFactory.createApplicationCoordinator(
            authService: authService,
            router: router
        )
        
        window.rootViewController = rootNavController
        window.makeKeyAndVisible()
        
        return (window, coordinator)
    }
}
