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
    
    init() {
        assemblyBuilder = AssemblyBuilderImpl()
        coordinatorsFactory = CoordinatorFactoryImpl(assemblyBuilder: assemblyBuilder)
        
        assemblyBuilder.di = self
    }
}

extension DI: AppFactory {
    func makeKeyWindowAndCoordinator(with windowScene: UIWindowScene) -> (UIWindow, Coordinator) {
        let rootNavController = UINavigationController()
        let router = RouterImpl(rootController: rootNavController)

        let window = UIWindow(windowScene: windowScene)
        let coordinator = coordinatorsFactory.createApplicationCoordinator(router: router)
        
        window.rootViewController = rootNavController
        window.makeKeyAndVisible()
        
        return (window, coordinator)
    }
}

//MARK: - AssemblyBuilder
final class AssemblyBuilderImpl: AssemblyBuilder {
    fileprivate weak var di: DI?

    func createOverviewModule() -> UIViewController {
        let view = OverviewController()
        
        return view
    }
    
    func createLoginModule() -> UIViewController {
        let view = OverviewController()
        
        return view
    }
}
