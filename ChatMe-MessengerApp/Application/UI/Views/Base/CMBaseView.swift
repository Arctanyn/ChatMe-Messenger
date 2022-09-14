//
//  CMBaseView.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

class CMBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupViews()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc extension CMBaseView: BaseViewSetup {
    func configureAppearance() { }
    func setupViews() { }
    func constraintViews() { }
}
