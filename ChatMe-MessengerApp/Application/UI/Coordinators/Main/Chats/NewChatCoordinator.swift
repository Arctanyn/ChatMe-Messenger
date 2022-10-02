//
//  NewChatCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit

final class NewChatCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: ((UserProfile?) -> Void)?
    
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(assemblyBuilder: AssemblyBuilder, router: Router) {
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        let module = assemblyBuilder.createNewChatModule(coordinator: self)
        router.presentInNavigation(module)
    }
    
    func backToChats() {
        router.dismissModule()
    }
    
    func goToChat(with user: UserProfile) {
        backToChats()
        finishFlow?(user)
    }
}
