//
//  CoordinatorsFactory.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

protocol CoordinatorFactory {
    func createApplicationCoordinator(router: Router) -> ApplicationCoordinator
    func createLoginCoordinator(router: Router) -> LoginCoordinator
    func createRegisterCoordinator(router: Router) -> RegisterCoordinator
    func createProfileRegisterCoordinator(user: PiecemealUser, router: Router) -> ProfileRegisterCoordinator
    func createCMCoordinator(router: Router) -> CMCoordinator
    func createChatsCoordinator(router: Router) -> ChatsCoordinator
    func createUserCoordinator(router: Router) -> UserCoordinator
}
