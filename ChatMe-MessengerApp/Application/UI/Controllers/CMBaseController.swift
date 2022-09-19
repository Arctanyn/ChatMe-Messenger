//
//  CMBaseController.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

class CMBaseController: UIViewController {

    //MARK: - Views
    
    private var backButton: UIBarButtonItem?
    
    //MARK: - View Controller Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupViews()
        constraintViews()
    }
    
    func setNewBackButton(target: Any?, action: Selector?) {
        backButton = UIBarButtonItem(
            image: Resources.Images.backArrow,
            style: .done,
            target: target,
            action: action
        )
        navigationItem.leftBarButtonItem = backButton
    }
    
    func changeBackButtonActiveStatus(to status: ActiveStatus) {
        guard let backButton = backButton else { return }
        backButton.isEnabled = status == .active
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
