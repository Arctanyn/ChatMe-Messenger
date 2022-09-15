//
//  UIView + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 11.09.2022.
//

import UIKit

extension UIView {
    func addSubview(_ view: UIView, useConstraints: Bool) {
        view.translatesAutoresizingMaskIntoConstraints = !useConstraints
        addSubview(view)
    }
    
    func addTopBorderLine(color: UIColor, height: CGFloat) {
        let borderLine = UIView()
        borderLine.backgroundColor = color
        borderLine.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        
        addSubview(borderLine)
        
        borderLine.frame = CGRect(x: 0, y: -height, width: bounds.width, height: height)
    }
    
    func addBottomBorderLine(color: UIColor, height: CGFloat) {
        let borderLine = UIView()
        borderLine.backgroundColor = color
        borderLine.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        addSubview(borderLine)
        
        borderLine.frame = CGRect(x: 0, y: frame.height, width: bounds.width, height: height)
    }
}
