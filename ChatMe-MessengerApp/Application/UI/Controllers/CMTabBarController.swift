//
//  CMTabBarController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case chats
    case user
}

final class CMTabBarController: UITabBarController {

    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Methods
    
    func configureViewControllers(with navigationControllers: [UINavigationController]) {
        for navigationController in navigationControllers {
            guard let tab = Tabs(rawValue: navigationController.tabBarItem.tag) else { break }
        
            switch tab {
            case .chats:
                setupViewController(
                    with: navigationController,
                    title: Resources.Strings.TabBar.chats,
                    tabBarImage: Resources.Images.TabBar.chats.tabImage,
                    tabBarSelectedImage: Resources.Images.TabBar.chats.tabSelectedImage
                )
            case .user:
                setupViewController(
                    with: navigationController,
                    title: Resources.Strings.TabBar.user,
                    tabBarImage: Resources.Images.TabBar.user.tabImage,
                    tabBarSelectedImage: Resources.Images.TabBar.user.tabSelectedImage
                )
            }
        }

        viewControllers = navigationControllers
    }
}

//MARK: - Private methods

private extension CMTabBarController {
    func configureAppearance() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.unselectedItemTintColor = Resources.Colors.inactive
        tabBar.backgroundColor = Resources.Colors.secondary

        tabBar.addTopBorderLine(color: .separator, height: 0.5)
    }
    
    func setupViewController(with navController: UINavigationController,
                                         title: String,
                                         tabBarImage: UIImage,
                                         tabBarSelectedImage: UIImage) {
        navController.tabBarItem.image = tabBarImage
        navController.tabBarItem.selectedImage = tabBarSelectedImage
        navController.tabBarItem.title = title
    }
}
