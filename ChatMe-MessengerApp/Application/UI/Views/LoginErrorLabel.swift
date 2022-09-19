//
//  LoginErrorLabel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import UIKit

final class LoginErrorLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = Resources.Fonts.system(size: 17, weight: .medium)
        numberOfLines = 0
        textColor = .systemRed
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
