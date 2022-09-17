//
//  ProfileRegisterCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import Foundation

final class ProfileRegisterCoordinator: BaseCoordinator {
    
    //MARK: Properties
    
    var finishFlow: BooleanClosure?
    
    private let user: User
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    //MARK: - Initialization
    
    init(user: User, assemblyBuilder: AssemblyBuilder, router: Router) {
        self.user = user
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    //MARK: - Methods
    
    override func start() {
        let module = assemblyBuilder.createProfileRegistrationProfile(user: user, coordinator: self)
        router.push(module)
    }
    
    func runMainFlow() {
        router.dismissModule()
        finishFlow?(true)
    }
    
    func backToAccountRegister() {
        router.popModule()
        finishFlow?(false)
    }
}
