//
//  DataEntryPageProtocol.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 19.11.2022.
//

import UIKit

protocol DataEntryPageProtocol: AnyObject, AlertPresenter, UITextFieldDelegate {
    var errorLabel: UILabel { get }
}

extension DataEntryPageProtocol where Self: UIViewController {
    func outputError(_ error: Error) {
        errorLabel.text = error.localizedDescription
        animateErrorOutput()
    }
    
    private func animateErrorOutput() {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.duration = 0.5
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5]
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.isAdditive = true
        errorLabel.layer.add(animation, forKey: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
