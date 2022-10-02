//
//  UIImage + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 03.10.2022.
//

import UIKit

extension UIImage {
    static func profileImage(from data: Data?) -> UIImage {
        guard let data,
              let image = UIImage(data: data)
        else {
            return Resources.Images.defaultProfileImage
        }
        
        return image
    }
}
