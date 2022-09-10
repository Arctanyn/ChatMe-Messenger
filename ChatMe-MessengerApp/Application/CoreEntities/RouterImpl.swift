//
//  RouterImpl.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 10.09.2022.
//

import UIKit

final class RouterImpl: Router {
    
    //MARK: Properties
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    //MARK: - Initialization
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    //MARK: - Methods
    
    func toPresent() -> UIViewController? {
        return rootController
    }

    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
}

