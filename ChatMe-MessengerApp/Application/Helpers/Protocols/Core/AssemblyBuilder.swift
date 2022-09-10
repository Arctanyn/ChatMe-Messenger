//
//  AssemblyBuilder.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

protocol AssemblyBuilder {
    func createOverviewModule() -> UIViewController
    func createLoginModule() -> UIViewController
}
