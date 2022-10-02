//
//  UserTableViewCell.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit

final class UserTableViewCell: UITableViewCell, ViewModelable {
    
    typealias ViewModel = UserTableViewCellViewModel
    
    //MARK: Properties
    
    static let identifier = "UserCell"
    
    var viewModel: ViewModel! {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Views
    
    private lazy var profileImageView = ProfileImageView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 20, weight: .medium)
        return label
    }()
    
    private lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 15, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var vStack = UIStackView(axis: .vertical, spacing: 5)
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
        setupViews()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private methods

private extension UserTableViewCell {
    func updateUI() {
        nameLabel.text = viewModel.name
 
        if let imageData = viewModel.profileImageData {
            profileImageView.image = UIImage(data: imageData)
        } else {
            profileImageView.image = Resources.Images.defaultProfileImage
        }
    }
}

//MARK: - BaseViewSetup

extension UserTableViewCell: BaseViewSetup {
    func configureAppearance() {
        backgroundColor = .clear
    }
    
    func setupViews() {
        contentView.addSubview(profileImageView, useConstraints: true)
        
        contentView.addSubview(vStack, useConstraints: true)
        
        vStack.addArrangedSubview(nameLabel)
        vStack.addArrangedSubview(additionalInfoLabel)
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            vStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    
}
