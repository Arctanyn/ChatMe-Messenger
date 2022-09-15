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
    
    func createLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(coordinatorsFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }

    func createRegisterCoordinator(router: Router) -> RegisterCoordinator {
        return RegisterCoordinator(assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createCMCoordinator(router: Router) -> CMCoordinator {
        return CMCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createUserCoordinator(router: Router) -> UserCoordinator {
        return UserCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createChatsCoordinator(router: Router) -> ChatsCoordinator {
        return ChatsCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
}
