//
//  UIImage + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 03.10.2022.
//

import UIKit

extension UIImage {
    var chatSize: CGSize {
        CGSize(width: size.width / 4, height: size.height / 4)
    }
    
    static func profileImage(from data: Data?) -> UIImage {
        guard let data,
              let image = UIImage(data: data)
        else {
            return Resources.Images.defaultProfileImage
        }
        return image
    }
    
    func toJpegString(compressionQuality quality: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: quality)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
