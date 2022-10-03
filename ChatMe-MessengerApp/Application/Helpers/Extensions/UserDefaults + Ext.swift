//
//  UserDefaults + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 02.10.2022.
//

import Foundation

extension UserDefaults {
    func getCurrentUser() -> UserProfile? {
        guard
            let data = UserDefaults.standard.data(forKey: "current_user"),
            let user = try? PropertyListDecoder().decode(UserProfile.self, from: data)
        else { return nil }
        return user
    }
    
    func addUser(_ user: UserProfile) {
        set(try? PropertyListEncoder().encode(user), forKey: "current_user")
    }
}
