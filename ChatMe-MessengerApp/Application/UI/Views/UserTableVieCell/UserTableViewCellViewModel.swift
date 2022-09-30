//
//  UserTableViewCellViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation
import FirebaseAuth

protocol UserTableViewCellViewModel {
    var name: String { get }
    var profileImageData: Data? { get }
    var additionalInfo: String? { get }
}

final class UserTableViewCellViewModelImpl: UserTableViewCellViewModel {
    
    //MARK: Properties
    
    var name: String {
        user.name
    }
    
    var profileImageData: Data? {
        user.profileImageData
    }
    
    var additionalInfo: String? {
        guard let currentUser = Auth.auth().currentUser else { return nil }
        return currentUser.email?.lowercased() == user.email.lowercased() ? "That's you" : nil
    }
    
    private let user: UserProfileModel
    
    //MARK: - Initialization
    
    init(user: UserProfileModel) {
        self.user = user
    }
}
