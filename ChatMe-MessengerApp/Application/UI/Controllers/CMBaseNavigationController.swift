//
//  CMBaseNavigationController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import UIKit

final class CMBaseNavigationController: UINavigationController {
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Private methods
    
    private func configureAppearance() {
        navigationBar.tintColor = Resources.Colors.active
        navigationBar.backgroundColor = Resources.Colors.background
    }
}
