//
//  UIViewController + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
    
    func changeUIInteraction(to status: ActiveStatus) {
        navigationController?.navigationBar.isUserInteractionEnabled = status == .active
        view.isUserInteractionEnabled = status == .active
    }
}
