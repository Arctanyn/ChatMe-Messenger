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
        
        static var defaultProfileImage: UIImage {
            UIImage(named: "default_profile_picture")!
        }
        
        static var overviewBackground: UIImage {
            UIImage(named: "overview_background_image")!
        }
        
        static var xMark: UIImage {
            UIImage(systemName: "xmark")!
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .bold))
        }
        
        static var xMarkCircle: UIImage {
            UIImage(systemName: "xmark.circle")!
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        }
        
        static var circlePhoto: UIImage {
            UIImage(systemName: "photo.circle")!
        }
        
        static var backArrow: UIImage {
            UIImage(systemName: "chevron.backward")!
        }
        
        static var squareAndPencil: UIImage {
            UIImage(systemName: "square.and.pencil")!
        }
        
        static var send: UIImage {
            UIImage(systemName: "arrow.up.circle.fill")!
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 25))
        }
        
        static var trash: UIImage {
            UIImage(systemName: "trash")!
        }
        
        static var paperclip: UIImage {
            UIImage(systemName: "paperclip")!
        }
        
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
    }
    
    //MARK: - Fonts
    
    enum Fonts {
        static func system(size: CGFloat, weight: UIFont.Weight) -> UIFont {
            return .systemFont(ofSize: size, weight: weight)
        }
    }
    
    //MARK: - Strings
    
    enum Strings {
        
        static var applicationName: String {
            "ChatMe"
        }
        
        static var somethingWentWrong: String {
            "Something went wrong"
        }
        
        static var processing: String {
            "Processing..."
        }
        
        static func toDeleteChat(with username: String) -> String {
            "Are you sure you want to delete the chat with \(username)?"
        }
        
        //MARK: TabBar
        
        enum TabBar {
            static var user: String {
                "User"
            }
            
            static var chats: String {
                "Chats"
            }
        }
        
        //MARK: - Login
        
        enum Login {
            static var logIn: String {
                "Log In"
            }
            
            static var signUp: String {
                "Sign Up"
            }
            
            static var logOut: String {
                "Log Out"
            }
        }
        
        //MARK: - Registration
        
        enum Register {
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
            
            static var completed: String {
                "Registration completed"
            }
            
            static var newAccountCreated: String {
                "You have successfully created a new account"
            }
            
            static var createNewAccount: String {
                "Create new account"
            }
        }
    }
}
