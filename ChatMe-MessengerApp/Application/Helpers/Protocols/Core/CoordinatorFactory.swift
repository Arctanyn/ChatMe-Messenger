//
//  CoordinatorsFactory.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

protocol CoordinatorFactory {
    func createApplicationCoordinator(authService: AuthService, router: Router) -> ApplicationCoordinator
    func createLoginCoordinator(router: Router) -> LoginCoordinator
    func createRegisterCoordinator(router: Router) -> AccountRegisterCoordinator
    func createProfileRegisterCoordinator(user: UserModel, router: Router) -> ProfileRegisterCoordinator
    func createCMCoordinator(router: Router) -> CMCoordinator
    func createChatsCoordinator(router: Router) -> ChatsCoordinator
    func createNewChatCoordinator(router: Router) -> NewChatCoordinator
    func createUserCoordinator(router: Router) -> UserCoordinator
}
