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
    
    //MARK: Properties
    
    private var navigationControllers: [UINavigationController] = []
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //MARK: - Methods
    
    func configureViewControllers(with tabs: [Tabs: UINavigationController]) {
        tabs.forEach { tab, navController in
            switch tab {
            case .chats:
                addNavigationController(
                    with: navController,
                    title: Resources.Strings.TabBar.chats,
                    tabBarImage: Resources.Images.TabBar.chats.tabImage,
                    tabBarSelectedImage: Resources.Images.TabBar.chats.tabSelectedImage
                )
            case .user:
                addNavigationController(
                    with: navController,
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
    }
    
    func addNavigationController(with navController: UINavigationController,
                                         title: String,
                                         tabBarImage: UIImage,
                                         tabBarSelectedImage: UIImage) {
        navController.tabBarItem.image = tabBarImage
        navController.tabBarItem.selectedImage = tabBarSelectedImage
        navController.tabBarItem.title = title
        navigationControllers.append(navController)
    }
}
