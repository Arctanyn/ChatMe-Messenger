//
//  UserViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 14.09.2022.
//

import UIKit

final class UserViewController: CMBaseController, ViewModelable {
    
    typealias ViewModel = UserViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.fetchUser() { [weak self] in
                self?.updateUI()
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var userInfoView = UserInfoView()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.setTitle(Resources.Strings.logOut, for: .normal)
        button.titleLabel?.font = Resources.Fonts.system(size: 20, weight: .medium)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Methods
    
    override func setupViews() {
        view.addSubview(userInfoView, useConstraints: true)
        view.addSubview(logOutButton, useConstraints: true)
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            userInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: - Actions

@objc private extension UserViewController {
    func logOutButtonPressed() {
        viewModel.logOut()
    }
}

//MARK: - Private methods

private extension UserViewController {
    func updateUI() {
        userInfoView.configure(
            name: viewModel.fullName,
            email: viewModel.email,
            profileImage: UIImage.profileImage(from: viewModel.profileImageData)
        )
    }
}
