//
//  ProfileRegisterViewController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import UIKit
import SPAlert

final class ProfileRegisterViewController: CMBaseController, DataEntryPageProtocol, ViewModelable {
    
    typealias ViewModel = ProfileRegisterViewModel

    //MARK: Properties
    
    var viewModel: ViewModel! {
        didSet {
            viewModel.newAccountDidCreate = { [weak self] in
                self?.loadingAlertView.dismiss()
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
                self?.loadingAlertView.dismiss()
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
    
    lazy var errorLabel: UILabel = LoginErrorLabel()

    private var profileImage: UIImage? {
        didSet {
            profileImageView.image = profileImage
        }
    }
    
    private lazy var loadingAlertView = SPAlertView(title: Resources.Strings.processing, preset: .spinner)
    
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
    
    private lazy var firstNameField = AuthorizationField(placeholder: "First name")
    private lazy var lastNameField = AuthorizationField(placeholder: "Last name (optional)")
    
    private lazy var createAccountButton: CMRoundedRectButton = {
        let button = CMRoundedRectButton(title: Resources.Strings.Register.createNewAccount)
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
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),

            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            vStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            authFieldsStack.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            labelsStack.bottomAnchor.constraint(equalTo: vStack.topAnchor, constant: -20),
            labelsStack.leadingAnchor.constraint(equalTo: vStack.leadingAnchor),
            labelsStack.trailingAnchor.constraint(equalTo: vStack.trailingAnchor),

            createAccountButton.widthAnchor.constraint(equalTo: vStack.widthAnchor)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//MARK: - Actions

@objc private extension ProfileRegisterViewController {
    func createAccountButtonPressed() {
        let firstName = firstNameField.textField.text ?? ""
        let lastName = lastNameField.textField.text
        
        if let error = viewModel.checkToValid(firstName: firstName, lastName: lastName) {
            errorLabel.isHidden = false
            outputError(error)
        } else {
            loadingAlertView.present()
            errorLabel.isHidden = true
            changeUIInteraction(to: .inactive)

            let imageData = profileImage?.jpegData(compressionQuality: 0.85)
            viewModel.createNewAccount(withName: firstName, lastName: lastName, profileImage: imageData)
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
        vStack.addArrangedSubviews([
            profileImageView,
            authFieldsStack,
            createAccountButton
        ])
    }
    
    func setupAuthFieldsStack() {
        [
            firstNameField,
            lastNameField
        ].forEach { authField in
            authField.textField.delegate = self
            authFieldsStack.addArrangedSubview(authField)
        }
        
        authFieldsStack.addArrangedSubview(errorLabel)
    }
    
    func setupLabelsStack() {
        view.addSubview(labelsStack, useConstraints: true)
        labelsStack.addArrangedSubviews([
            titleLabel,
            infoLabel
        ])
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
        profileImage = image
        picker.dismiss(animated: true)
    }
}

extension ProfileRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField === self.firstNameField.textField {
            self.lastNameField.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
