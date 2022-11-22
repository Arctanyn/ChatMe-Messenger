//
//  Date + Ext.swift
//  ChatMe-MessengerApp
//
//  Created by Малиль Дугулюбгов on 22.11.2022.
//

import Foundation

extension Date {
    static func chatSendingTime(_ sendingDate: Date) -> String {
        let pastTime = Date().timeIntervalSince(sendingDate)
        
        let secondsInMinute: Double = 60
        let secondsInHour = secondsInMinute * 60
        let secondsInDay = secondsInHour * 24
        
        var sendingTime = Double()
        var units = String()
        
        switch pastTime {
        case (0..<secondsInMinute):
            return "Just now"
        case (secondsInMinute..<secondsInHour):
            units = "m"
            sendingTime = (pastTime / secondsInMinute).rounded()
        case (secondsInHour..<secondsInDay):
            units = "h"
            sendingTime = (pastTime / secondsInHour).rounded()
        default:
            units = "d"
            sendingTime = (pastTime / secondsInDay).rounded()
        }
        
        return "\(Int(sendingTime))\(units)"
    }
}
