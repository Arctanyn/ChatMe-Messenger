//
//  ChatCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 02.10.2022.
//

import Foundation

final class ChatCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: VoidClosure?
    
    private let user: UserProfile
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(user: UserProfile, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.user = user
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        let module = assemblyBuilder.createChatModule(with: user, coordinator: self)
        router.push(module)
    }
}
