//
//  Media.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 07.10.2022.
//

import Foundation
import MessageKit

struct Media: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
