//
//  ChatTableViewCell.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 08.10.2022.
//

import UIKit

final class ChatTableViewCell: UITableViewCell, ViewModelable {

    typealias ViewModel = ChatTableViewCellViewModel
    
    //MARK: Properties
    
    static let identifier = "ChatTableViewCell"
    
    var viewModel: ViewModel! {
        didSet {
            updateUI()
        }
    }
    
    //MARK: - Views
    
    private lazy var userProfileImageView = ProfileImageView()
    
    private lazy var horizontalStack = UIStackView(axis: .horizontal, spacing: 8, distribution: .fillProportionally)
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 19, weight: .medium)
        return label
    }()
    
    private lazy var lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 15, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var sendingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.system(size: 15, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var labelsStack = UIStackView(axis: .vertical, spacing: 5)
    
    private lazy var messageInfoLabelsStack = UIStackView(axis: .horizontal, spacing: 10)

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

private extension ChatTableViewCell {
    func updateUI() {
        userProfileImageView.image = UIImage.profileImage(from: viewModel.userProfileImageData)
        usernameLabel.text = viewModel.username
        lastMessageLabel.text = viewModel.lastMessage
        sendingTimeLabel.text = "• \(viewModel.sendingTime)"
    }
}

//MARK: - BaseViewSetup

extension ChatTableViewCell: BaseViewSetup {
    func configureAppearance() {
        contentView.backgroundColor = Resources.Colors.background
    }
    
    func setupViews() {
        contentView.addSubview(userProfileImageView, useConstraints: true)
        
        messageInfoLabelsStack.addArrangedSubviews([
            lastMessageLabel,
            sendingTimeLabel
        ])
        
        contentView.addSubview(labelsStack, useConstraints: true)
        labelsStack.addArrangedSubviews([
            usernameLabel,
            messageInfoLabelsStack
        ])
        
    }
    
    func constraintViews() {
        sendingTimeLabel.setContentHuggingPriority(.required, for: .horizontal)
        lastMessageLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            userProfileImageView.widthAnchor.constraint(equalToConstant: 55),
            userProfileImageView.heightAnchor.constraint(equalTo: userProfileImageView.widthAnchor),
            userProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userProfileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userProfileImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            labelsStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            labelsStack.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
