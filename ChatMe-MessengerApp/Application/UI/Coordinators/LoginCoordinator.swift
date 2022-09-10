//
//  LoginCoordinator.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

final class LoginCoordinator: BaseCoordinator {
    
    var finishFlow: (() -> Void)?
    
    private let assemblyBuilder: AssemblyBuilder
    private let router: Router
    
    init(assemblyBuilder: AssemblyBuilder, router: Router) {
        self.assemblyBuilder = assemblyBuilder
        self.router = router
    }
    
    override func start() {
        let viewController = assemblyBuilder.createLoginModule()
        router.setRootModule(viewController, hideBar: true)
    }
}
