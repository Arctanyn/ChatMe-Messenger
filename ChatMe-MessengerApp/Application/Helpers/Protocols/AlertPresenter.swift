//
//  AlertPresenter.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 18.09.2022.
//

import UIKit
import SPAlert

protocol AlertPresenter: AnyObject {
     
}

extension AlertPresenter where Self: UIViewController {
    
    //MARK: - Methods

    func showDoneAlert(withTitle title: String,
                       message: String? = nil,
                       duration: Double,
                       completion: VoidClosure? = nil) {
        let alert = SPAlertView(title: title, message: message, preset: .done)
        alert.iconView?.tintColor = Resources.Colors.active
        alert.duration = duration
        alert.present(completion: completion)
    }

    func showAuthErrorAlert(withTitle title: String,
                        message: String? = nil,
                        duration: Double,
                        completion: VoidClosure? = nil) {
        let alert = SPAlertView(
            title: title,
            message: message,
            preset: .custom(UIImage(systemName: "person.fill.xmark")!.withRenderingMode(.alwaysTemplate))
        )
        alert.iconView?.tintColor = .systemRed
        alert.duration = duration
        alert.present(completion: completion)
    }
}
