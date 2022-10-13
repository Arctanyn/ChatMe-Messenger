//
//  ObservedObject.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 20.09.2022.
//

import Foundation

final class ObservableObject<T> {
    
    typealias Listener = VoidClosure
    typealias ValueListener = (T) -> Void
    
    var value: T {
        didSet {
            listener?()
            valueListener?(value)
        }
    }
    
    private var listener: Listener?
    private var valueListener: ValueListener?
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
    }
    
    func bind(valueListener: @escaping ValueListener) {
        self.valueListener = valueListener
    }
}
