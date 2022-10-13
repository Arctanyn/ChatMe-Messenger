//
//  UserDefaults + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 02.10.2022.
//

import Foundation

extension UserDefaults {
    
    enum CMUserKey {
        static let currentUser = "current_user"
    }
    
    func getCurrentUser() -> UserProfile? {
        guard
            let data = UserDefaults.standard.data(forKey: CMUserKey.currentUser),
            let user = try? PropertyListDecoder().decode(UserProfile.self, from: data)
        else { return nil }
        return user
    }
    
    func addUser(_ user: UserProfile) {
        set(try? PropertyListEncoder().encode(user), forKey: CMUserKey.currentUser)
    }
    
    func deleteCurrentUser() {
        removeObject(forKey: CMUserKey.currentUser)
    }
}
