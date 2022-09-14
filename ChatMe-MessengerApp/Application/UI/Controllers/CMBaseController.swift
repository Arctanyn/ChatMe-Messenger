//
//  CMBaseController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

class CMBaseController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViews()
        constraintViews()
    }
}

@objc extension CMBaseController: BaseViewSetup {
    func configureAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    func setupViews() { }
    func constraintViews() { }
}
