//
//  UIView + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

extension UIView {
    func addSubview(_ view: UIView, useConstraints: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = !useConstraints
        addSubview(view)
    }
}
