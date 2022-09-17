//
//  ProfileImageView.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import UIKit

final class ProfileImageView: UIImageView {
    
    //MARK: - Initialization
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        tintColor = .lightGray
        backgroundColor = Resources.Colors.secondary
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
}
