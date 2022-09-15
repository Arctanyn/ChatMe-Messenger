//
//  RegisterViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import UIKit

final class RegisterViewController: CMBaseController, ViewModelable {
    
    typealias ViewModel = RegisterViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel!
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK: - Methods
    
    func configure(with viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
}

@objc private extension RegisterViewController {
    func closeButtonPressed() {
        viewModel.backToLogin()
    }
}

//MARK: - Private methods

private extension RegisterViewController {
    func setupNavigationBar() {
        title = "ChatMe"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Resources.Images.xMark,
            style: .plain,
            target: self,
            action: #selector(closeButtonPressed)
        )
    }
}
