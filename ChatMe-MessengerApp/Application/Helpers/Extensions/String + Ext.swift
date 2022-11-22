//
//  String + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 19.09.2022.
//

import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isBeginWithString(_ str: String) -> Bool {
        return self.lowercased().hasPrefix(str.lowercased())
    }
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
