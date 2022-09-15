//
//  OverviewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class LoginViewController: CMBaseController, ViewModelable {

    typealias ViewModel = LoginViewModel
    
    //MARK: Properties
    
    var viewModel: ViewModel!
    
    //MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ChatMe"
        label.font = Resources.Fonts.system(size: 35, weight: .bold)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error description"
        label.font = Resources.Fonts.system(size: 17, weight: .medium)
        label.textColor = .systemRed
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailField: AuthorizationField = {
        let field = AuthorizationField(placeholder: "Email")
        field.textField.keyboardType = .emailAddress
        return field
    }()
    
    private lazy var passwordField = AuthorizationField(placeholder: "Password", isSecureText: true)
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 25)
    private lazy var authFieldsStack = UIStackView(axis: .vertical, spacing: 10)
    private lazy var authButtonsStack = UIStackView(axis: .vertical, spacing: 10)
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle(Resources.Strings.logIn, for: .normal)
        button.titleLabel?.font = Resources.Fonts.system(size: 17, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
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
    
    //MARK: - Methods
    
    override func setupViews() {
        setupAuthFieldsStack()
        setupAuthButtonsStack()
        setupVerticalStack()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        errorLabel.isHidden = true
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 40),
            
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
        
        view.setNeedsLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

//MARK: - Actions

@objc private extension LoginViewController {
    func loginButtonPressed() {
        let email = emailField.textField.text ?? ""
        let password = emailField.textField.text ?? ""
        
        if let error = viewModel.checkToValid(email: email, password: password) {
            errorLabel.text = error.errorDescription
            errorLabel.isHidden = false
        } else {
            viewModel.login()
        }
    }
    
    func signUpButtonPressed() {
        viewModel.showSingUpPage()
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
    
    func isFieldsEmpty() -> Bool {
        return !(emailField.textField.text ?? "").isEmpty && !(passwordField.textField.text ?? "").isEmpty
    }
}

//MARK: - UITableViewDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField === self.emailField.textField {
            self.passwordField.textField.becomeFirstResponder()
        }
        
        return true
    }
    

}
