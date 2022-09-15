//
//  Resources.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

enum Resources {
    
    //MARK: - Colors
    
    enum Colors {
        static var active: UIColor {
            UIColor("#437BFE")
        }
        
        static var inactive: UIColor {
            UIColor("#929DA5")
        }

        static var background: UIColor {
            .secondarySystemGroupedBackground
        }
        
        static var secondary: UIColor {
            .tertiarySystemGroupedBackground
        }
    }
    
    //MARK: - Images
    
    enum Images {
        
        //MARK: TabBar
        
        enum TabBar {
            case chats
            case user
            
            var tabImage: UIImage {
                switch self {
                case .chats:
                    return UIImage(systemName: "message")!
                case .user:
                    return UIImage(systemName: "person")!
                }
            }
            
            var tabSelectedImage: UIImage {
                switch self {
                case .chats:
                    return UIImage(systemName: "message.fill")!
                case .user:
                    return UIImage(systemName: "person.fill")!
                }
            }
        }
        
        static var overviewBackground: UIImage {
            UIImage(named: "overview_background_image")!
        }
        
        static var xMark: UIImage {
            UIImage(systemName: "xmark")!
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        }
    }
    
    //MARK: - Fonts
    
    enum Fonts {
        static func system(size: CGFloat, weight: UIFont.Weight) -> UIFont {
            return .systemFont(ofSize: size, weight: weight)
        }
    }
    
    //MARK: - Strings
    
    enum Strings {
        
        //MARK: TabBar
        
        enum TabBar {
            static var user: String {
                "User"
            }
            
            static var chats: String {
                "Chats"
            }
        }
        
        static var logIn: String {
            "Log in"
        }
        
        static var signUp: String {
            "Sign up"
        }
    }
}
