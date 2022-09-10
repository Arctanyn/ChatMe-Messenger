//
//  CoordinatorFactoryImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    //MARK: Properties
    
    private let assemblyBuilder: AssemblyBuilder
    
    //MARK: - Initialization
    
    init(assemblyBuilder: AssemblyBuilder) {
        self.assemblyBuilder = assemblyBuilder
    }
    
    //MARK: - Methods
    
    func createApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createOverviewCoordinator(router: Router) -> OverviewCoordinator {
        return OverviewCoordinator(assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(assemblyBuilder: assemblyBuilder, router: router)
    }
}
