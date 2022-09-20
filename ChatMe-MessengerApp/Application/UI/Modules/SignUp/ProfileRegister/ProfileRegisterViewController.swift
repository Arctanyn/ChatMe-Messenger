//
//  ProfileRegisterViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import UIKit
import SPAlert

final class ProfileRegisterViewController: CMBaseController, ViewModelable, AlertPresenter {
    
    typealias ViewModel = ProfileRegisterViewModel

    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.newAccountDidCreate = { [weak self] in
                self?.showDoneAlert(
                    withTitle: Resources.Strings.Register.completed,
                    message: Resources.Strings.Register.newAccountCreated,
                    duration: 2.5,
                    completion: {
                        self?.viewModel.completeRegistration()
                    }
                )
            }
            
            viewModel.displayError = { [weak self] error in
                self?.showAuthErrorAlert(
                    withTitle: Resources.Strings.somethingWentWrong,
                    message: error.localizedDescription,
                    duration: 2,
                    completion: {
                        self?.changeUIInteraction(to: .active)
                    }
                )
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        return picker
    }()
    
    private lazy var titleLabel: CMTitleLabel = {
        let label = CMTitleLabel()
        label.text = Resources.Strings.Register.profileRegistrationTitle
        return label
    }()
    
    private lazy var infoLabel: CMInfoLabel = {
        let label = CMInfoLabel()
        label.text = Resources.Strings.Register.profileRegistrationInfo
        return label
    }()
    
    private lazy var profileImageView = ProfileImageView()
    
    private lazy var usernameFiled = AuthorizationField(placeholder: "First name")
    private lazy var lastNameField = AuthorizationField(placeholder: "Last name (optional)")
    
    private lazy var errorLabel = LoginErrorLabel()
    
    private lazy var createAccountButton: CMRoundedRectButton = {
        let button = CMRoundedRectButton(title: Resources.Strings.createNewAccount)
        button.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 20, alignment: .center)
    private lazy var labelsStack = UIStackView(axis: .vertical, spacing: 5)
    private lazy var authFieldsStack = UIStackView(axis: .vertical, spacing: 10)
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Resources.Strings.applicationName
        setNewBackButton(target: self, action: #selector(goBack))
    }

    //MARK: - Methods
    
    override func setupViews() {
        imagePicker.delegate = self
        
        setupProfileImageView()
        
        setupAuthFieldsStack()
        setupLabelsStack()
        setupVerticalStack()
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 130),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),

            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            authFieldsStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),

            createAccountButton.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
    }
}

//MARK: - Actions

@objc private extension ProfileRegisterViewController {
    func createAccountButtonPressed() {
        let username = usernameFiled.textField.text ?? ""
        let lastName = lastNameField.textField.text
        
        if let error = viewModel.checkToValid(username: username, lastName: lastName) {
            errorLabel.text = error.errorDescription
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
            
            changeUIInteraction(to: .inactive)
            
            let alertView = SPAlertView(title: Resources.Strings.processing, preset: .spinner)
            alertView.present()
            
            let imageData = profileImageView.image?.pngData()
            viewModel.createNewAccount(withName: username, lastName: lastName, profileImage: imageData) {
                alertView.dismiss()
            }
        }
    }
    
    func selectImage() {
        present(imagePicker, animated: true)
    }
    
    func goBack() {
        viewModel.backToAccountRegister()
    }
}

//MARK: - Private methods

private extension ProfileRegisterViewController {
    func setupVerticalStack() {
        view.addSubview(vStack, useConstraints: true)
        vStack.addArrangedSubview(labelsStack)
        vStack.addArrangedSubview(profileImageView)
        vStack.addArrangedSubview(authFieldsStack)
        vStack.addArrangedSubview(createAccountButton)
    }
    
    func setupAuthFieldsStack() {
        [
            usernameFiled,
            lastNameField
        ].forEach { authField in
            authFieldsStack.addArrangedSubview(authField)
        }
        
        authFieldsStack.addArrangedSubview(errorLabel)
    }
    
    func setupLabelsStack() {
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(infoLabel)
    }

    func setupProfileImageView() {
        profileImageView.image = Resources.Images.circlePhoto
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(gesture)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension ProfileRegisterViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImageView.image = image
        picker.dismiss(animated: true)
    }
}

