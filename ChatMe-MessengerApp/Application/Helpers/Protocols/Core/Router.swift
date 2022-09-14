//
//  Router.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}

protocol Router: Presentable {
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
}
