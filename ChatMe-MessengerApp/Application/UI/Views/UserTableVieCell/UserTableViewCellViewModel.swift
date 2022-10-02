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
}

final class UserTableViewCellViewModelImpl: UserTableViewCellViewModel {
    
    //MARK: Properties
    
    var name: String {
        user.fullName
    }
    
    var profileImageData: Data? {
        user.profileImageData
    }
    
    private let user: UserProfile
    
    //MARK: - Initialization
    
    init(user: UserProfile) {
        self.user = user
    }
}
