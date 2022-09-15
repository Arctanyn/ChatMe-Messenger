//
//  ViewModelable.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 15.09.2022.
//

import Foundation

protocol ViewModelable: AnyObject {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
}
