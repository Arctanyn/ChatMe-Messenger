//
//  OverviewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class LoginViewController: CMBaseController, ViewModelable, AlertPresenter {

    typealias ViewModel = LoginViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.displayError = { [weak self] error in
                self?.showAuthErrorAlert(
                    withTitle: error.errorDescription!,
                    message: "Specify the valid details of your account",
                    duration: 2
                )
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.applicationName
        label.font = Resources.Fonts.system(size: 35, weight: .bold)
        return label
    }()
    
    private lazy var errorLabel = LoginErrorLabel()
    
    private lazy var emailField: AuthorizationField = {
        let field = AuthorizationField(placeholder: "Email")
        field.textField.keyboardType = .emailAddress
        return field
    }()
    
    private lazy var passwordField = AuthorizationField(placeholder: "Password",
                                                        isSecureText: true)
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 25)
    private lazy var authFieldsStack = UIStackView(axis: .vertical, spacing: 10)
    private lazy var authButtonsStack = UIStackView(axis: .vertical, spacing: 10)
    
    private lazy var logInButton: CMRoundedRectButton = {
        let button = CMRoundedRectButton(title: Resources.Strings.logIn)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Strings.signUp, for: .normal)
        button.titleLabel?.font = Resources.Fonts.system(size: 17, weight: .medium)
        button.tintColor = .label
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - View Controller Lyfecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.textField.text = nil
        passwordField.textField.text = nil
        errorLabel.isHidden = true
    }
    
    //MARK: - Methods
    
    override func setupViews() {
        setupAuthFieldsStack()
        setupAuthButtonsStack()
        setupVerticalStack()
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - Actions

@objc private extension LoginViewController {
    func loginButtonPressed() {
        let email = emailField.textField.text ?? ""
        let password = passwordField.textField.text ?? ""
        
        if let error = viewModel.checkToValid(email: email, password: password) {
            errorLabel.text = error.errorDescription
            errorLabel.isHidden = false
        } else {
            viewModel.login(withEmail: email, password: password)
        }
    }
    
    func signUpButtonPressed() {
        viewModel.showSignUpPage()
    }
}

//MARK: - Private methods

private extension LoginViewController {
    func setupAuthFieldsStack() {
        [
            emailField,
            passwordField
        ].forEach { authField in
            authField.textField.delegate = self
            authFieldsStack.addArrangedSubview(authField)
        }
        
        authFieldsStack.addArrangedSubview(errorLabel)
    }
    
    func setupAuthButtonsStack() {
        [
            logInButton,
            signUpButton
        ].forEach { authButtonsStack.addArrangedSubview($0) }
    }
    
    func setupVerticalStack() {
        view.addSubview(vStack, useConstraints: true)
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(authFieldsStack)
        vStack.addArrangedSubview(authButtonsStack)
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField === self.emailField.textField {
            self.passwordField.textField.becomeFirstResponder()
        }
        
        return true
    }
    

}
