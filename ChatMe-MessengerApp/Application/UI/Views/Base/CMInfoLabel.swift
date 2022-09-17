//
//  CMInfoLabel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import UIKit

final class CMInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .darkGray
        font = Resources.Fonts.system(size: 15, weight: .medium)
        numberOfLines = 0
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
