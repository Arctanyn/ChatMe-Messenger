//
//  AssemblyBuilder.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

protocol AssemblyBuilder {
    func createLoginModule(coordinator: Coordinator) -> UIViewController
    func createRegisterModule(coordinator: Coordinator) -> UIViewController
    func createProfileRegistrationProfile(user: PiecemealUser, coordinator: Coordinator) -> UIViewController
    func createChatsModule(coordinator: Coordinator) -> UIViewController
    func createUserModule(coordinator: Coordinator) -> UIViewController
}
