//
//  CMRoundedRectButton.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import UIKit

final class CMRoundedRectButton: UIButton {
    
    //MARK: Initialization
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        
        configureAppearance()
        setupViews()
        constraintViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - BaseViewSetup

extension CMRoundedRectButton: BaseViewSetup {
    func configureAppearance() {
        makeSystem()
        
        layer.cornerRadius = 5
        backgroundColor = Resources.Colors.active
        titleLabel?.font = Resources.Fonts.system(size: 17, weight: .medium)
        tintColor = .lightGray
    }
    
    func setupViews() {
        
    }
    
    func constraintViews() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
