//
//  UserInfoView.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import UIKit

final class UserInfoView: CMBaseView {
    
    //MARK: - Views
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 10, alignment: .center)
    private lazy var textLabelsStackView = UIStackView(axis: .vertical, spacing: 5, alignment: .center)
    
    private lazy var profileImageView = ProfileImageView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 30, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 17, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Methods
    
    func configure(name: String, email: String, profileImage: UIImage?) {
        nameLabel.text = name
        emailLabel.text = email
        profileImageView.image = profileImage
    }
    
    override func setupViews() {
        textLabelsStackView.addArrangedSubviews([
            nameLabel,
            emailLabel
        ])
        
        addSubview(vStack, useConstraints: true)
        vStack.addArrangedSubviews([
            profileImageView,
            textLabelsStackView
        ])
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
