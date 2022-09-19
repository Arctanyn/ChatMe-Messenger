//
//  AuthErrorPresenter.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 18.09.2022.
//

import Foundation

protocol AuthErrorPresenter {
    var displayError: ((AuthError) -> Void)? { get set }
}
