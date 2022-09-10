//
//  CoordinatorsFactory.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import Foundation

protocol CoordinatorFactory {
    func createApplicationCoordinator(router: Router) -> ApplicationCoordinator
    func createOverviewCoordinator(router: Router) -> OverviewCoordinator
    func createLoginCoordinator(router: Router) -> LoginCoordinator
}
