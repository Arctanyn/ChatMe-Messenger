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
        
        static var circlePhoto: UIImage {
            UIImage(systemName: "photo.circle")!
        }
        
        static var backArrow: UIImage {
            UIImage(systemName: "chevron.backward")!
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
        
        //MARK: - Registration
        
        enum Registration {
            static var accountRegistrationTitle: String {
                "Create a new account"
            }
            
            static var accountRegistrationInfo: String {
                "To create an account, you will need to specify your email address and come up with a password"
            }
            
            static var profileRegistrationTitle: String {
                "Enter your name and upload a photo"
            }
            
            static var profileRegistrationInfo: String {
                "Enter a name and optionally select a profile picture"
            }
        }
        
        static var applicationName: String {
            "ChatMe"
        }
        
        static var logIn: String {
            "Log in"
        }
        
        static var signUp: String {
            "Sign up"
        }
    }
}
