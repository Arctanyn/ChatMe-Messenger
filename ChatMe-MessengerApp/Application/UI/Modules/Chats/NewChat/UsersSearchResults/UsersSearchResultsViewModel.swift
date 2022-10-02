//
//  UsersSearchResultsViewModel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import Foundation

//MARK: UsersSearchResultsViewModel
 
protocol UsersSearchResultsViewModel {
    var numberOfResults: Int { get }
    func viewModelForCell(at indexPath: IndexPath) -> UserTableViewCellViewModel
    func didSelectRow(at indexPath: IndexPath)
}

//MARK: UsersSearchResultsViewModelImpl

final class UserSearchResultsViewModelImpl: UsersSearchResultsViewModel {
    
    //MARK: Properties
    
    var numberOfResults: Int {
        users.count
    }
    
    var userSelected: ((UserProfile) -> Void)?
    
    private let users: [UserProfile]
    
    //MARK: - Initialization
    
    init(users: [UserProfile]) {
        self.users = users
    }
    
    //MARK: - Methods
    
    func viewModelForCell(at indexPath: IndexPath) -> UserTableViewCellViewModel {
        return UserTableViewCellViewModelImpl(user: users[indexPath.row])
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        userSelected?(users[indexPath.row])
    }
}
