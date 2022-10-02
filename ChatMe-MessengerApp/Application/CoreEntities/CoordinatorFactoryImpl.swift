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
    
    func createApplicationCoordinator(authService: AuthService, router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(authService: authService, coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(coordinatorsFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }

    func createRegisterCoordinator(router: Router) -> AccountRegisterCoordinator {
        return AccountRegisterCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createProfileRegisterCoordinator(user: PiecemealUser, router: Router) -> ProfileRegisterCoordinator {
        return ProfileRegisterCoordinator(user: user, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createCMCoordinator(router: Router) -> CMCoordinator {
        return CMCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createUserCoordinator(router: Router) -> UserCoordinator {
        return UserCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createChatCoordinator(user: UserProfile, router: Router) -> ChatCoordinator {
        return ChatCoordinator(user: user, assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createNewChatCoordinator(router: Router) -> NewChatCoordinator {
        return NewChatCoordinator(assemblyBuilder: assemblyBuilder, router: router)
    }
    
    func createChatsCoordinator(router: Router) -> ChatsCoordinator {
        return ChatsCoordinator(coordinatorFactory: self, assemblyBuilder: assemblyBuilder, router: router)
    }
}
