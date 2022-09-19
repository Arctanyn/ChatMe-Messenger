//
//  UIButton + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 16.09.2022.
//

import UIKit

extension UIButton {
    func makeSystem() {
        addTarget(self, action: #selector(handleIn), for: [
            .touchDown,
            .touchDragInside
        ])
        
        addTarget(self, action: #selector(handleOut), for: [
            .touchDragOutside,
            .touchDragExit,
            .touchUpInside,
            .touchUpOutside,
            .touchCancel
        ])
    }
}

@objc private extension UIButton {
    func handleIn() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.5
        }
    }
    
    func handleOut() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1
        }
    }
}
