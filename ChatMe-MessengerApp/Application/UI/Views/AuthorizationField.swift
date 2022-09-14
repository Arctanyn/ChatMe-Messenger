//
//  AuthorizationField.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

final class AuthorizationField: CMBaseView {
    
    //MARK: Properties
    
    private let padding: CGFloat = 10
    
    var placeholder: String? {
        get {
            textField.placeholder
        }
        
        set {
            textField.placeholder = newValue
        }
    }
    
    var isSecureText: Bool {
        get {
            textField.isSecureTextEntry
        }
        
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    //MARK: - Views

    private(set) lazy var textField: UITextField = {
        let field = UITextField()
        field.borderStyle = .none
        field.tintColor = .label
        field.autocorrectionType = .no
        field.font = Resources.Fonts.system(size: 17, weight: .medium)
        return field
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    init(placeholder: String, isSecureText: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureText = isSecureText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func addTextFieldAction(sender: Any?, action: Selector, for event: UIControl.Event) {
        textField.addTarget(sender, action: action, for: event)
    }
    
    override func configureAppearance() {
        backgroundColor = .secondarySystemBackground
    }
    
    override func setupViews() {
        addSubview(textField, useConstraints: true)
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

