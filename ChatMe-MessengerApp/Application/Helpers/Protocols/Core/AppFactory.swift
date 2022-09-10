//
//  AppFactory.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

protocol AppFactory {
    func makeKeyWindowAndCoordinator(with windowScene: UIWindowScene) -> (UIWindow, Coordinator)
}
