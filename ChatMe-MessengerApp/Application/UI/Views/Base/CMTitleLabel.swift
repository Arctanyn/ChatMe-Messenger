//
//  CMTitleLabel.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 17.09.2022.
//

import UIKit

final class CMTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = Resources.Fonts.system(size: 28, weight: .bold)
        numberOfLines = 2
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
