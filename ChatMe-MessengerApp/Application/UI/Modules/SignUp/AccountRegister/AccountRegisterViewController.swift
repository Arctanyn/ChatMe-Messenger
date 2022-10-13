//
//  AccountRegisterViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import UIKit

final class AccountRegisterViewController: CMBaseController, ViewModelable {
    
    typealias ViewModel = AccountRegisterViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel!
    
    //MARK: - Views
    
    private lazy var titleLabel: CMTitleLabel = {
        let label = CMTitleLabel()
        label.text = Resources.Strings.Register.createNewAccount
        return label
    }()
    
    private lazy var infoLabel: CMInfoLabel = {
        let label = CMInfoLabel()
        label.text = Resources.Strings.Register.accountRegistrationInfo
        return label
    }()
    
    private lazy var emailField: AuthorizationField = {
        let authField = AuthorizationField(placeholder: "Email")
        authField.textField.keyboardType = .emailAddress
        return authField
    }()
    
    private lazy var passwordField = AuthorizationField(placeholder: "Password",
                                                       isSecureText: true)
    
    private lazy var repeatPasswordField = AuthorizationField(placeholder: "Repeat password",
                                                             isSecureText: true)
    
    private lazy var errorLabel = LoginErrorLabel()
    
    private lazy var continueButton: CMRoundedRectButton = {
        let button = CMRoundedRectButton(title: "Continue")
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 25)
    private lazy var labelsStack = UIStackView(axis: .vertical, spacing: 5)
    private lazy var authFieldsStack = UIStackView(axis: .vertical, spacing: 10)
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorLabel.isHidden = true
    }
    
    //MARK: - Methods
    
    func configure(with viewModel: AccountRegisterViewModel) {
        self.viewModel = viewModel
    }
    
    override func setupViews() {
        setupLabelsStack()
        setupAuthFieldsStack()
        setupVerticalStack()
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            labelsStack.bottomAnchor.constraint(equalTo: vStack.topAnchor, constant: -20),
            labelsStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - Actions

@objc private extension AccountRegisterViewController {
    func closeButtonPressed() {
        viewModel.backToLogin()
    }
    
    func continueButtonPressed() {
        let email = emailField.textField.text ?? ""
        let password = passwordField.textField.text ?? ""
        let repeatedPassword = repeatPasswordField.textField.text ?? ""
        
        if let error = viewModel.checkToValid(email: email,
                                              password: password,
                                              repeatedPassword: repeatedPassword) {
            errorLabel.text = error.errorDescription
            errorLabel.isHidden = false
        } else {
            viewModel.showProfileRegistrationPage(withEmailAdress: email, password: password)
        }
    }
}

//MARK: - Private methods

private extension AccountRegisterViewController {
    func setupNavigationBar() {
        title = Resources.Strings.applicationName
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Resources.Images.xMark,
            style: .plain,
            target: self,
            action: #selector(closeButtonPressed)
        )
    }
    
    func setupVerticalStack() {
        view.addSubview(vStack, useConstraints: true)
        vStack.addArrangedSubview(authFieldsStack)
        vStack.addArrangedSubview(continueButton)
    }
    
    func setupLabelsStack() {
        view.addSubview(labelsStack, useConstraints: true)
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(infoLabel)
    }
    
    func setupAuthFieldsStack() {
        [
            emailField,
            passwordField,
            repeatPasswordField
        ].forEach { authField in
            authField.textField.delegate = self
            authFieldsStack.addArrangedSubview(authField)
        }
        
        authFieldsStack.addArrangedSubview(errorLabel)
    }
}

//MARK: - UITextFieldDelegate

extension AccountRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField === self.emailField.textField {
            self.passwordField.textField.becomeFirstResponder()
        } else if textField === self.passwordField.textField {
            self.repeatPasswordField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
