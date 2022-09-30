//
//  ChatTableViewCell.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 26.09.2022.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
    
    //MARK: - Views
    
    private lazy var profileImageView = ProfileImageView()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
