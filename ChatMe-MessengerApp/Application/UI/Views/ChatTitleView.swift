//
//  ChatTitleView.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 08.10.2022.
//

import UIKit

final class ChatTitleView: UIView {
    
    //MARK: - Views
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 18, weight: .medium)
        return label
    }()
    
    private lazy var profileImageView = ProfileImageView()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupViews()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func configure(username: String, profileImage: UIImage) {
        self.usernameLabel.text = username
        self.profileImageView.image = profileImage
    }
}

//MARK: - BaseViewSetup

extension ChatTitleView: BaseViewSetup {
    func configureAppearance() { }
    
    func setupViews() {
        addSubview(usernameLabel, useConstraints: true)
        addSubview(profileImageView, useConstraints: true)
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 35),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
