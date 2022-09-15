//
//  CMBaseController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

class CMBaseController: UIViewController {
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViews()
        constraintViews()
    }
}

//MARK: - BaseViewSetup

@objc extension CMBaseController: BaseViewSetup {
    func configureAppearance() {
        view.backgroundColor = Resources.Colors.background
    }
    
    func setupViews() { }
    func constraintViews() { }
}
