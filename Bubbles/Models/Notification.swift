//
//  Notification.swift
//  Bubbles
//
//  Created by Jessie P on 7/15/23.
//

import Foundation
import Firebase
struct Notification : Codable, Identifiable {
    var id: String
    let timeStamp: Timestamp
    let type: Int
    let uid: String
}

enum NotificationType: Int, Codable {
    case confirm // raw value 1
    case reminder // raw value 2
    case completeGrooming// raw value 3

    
    var notifivationMessage: String {
        switch self {
        case .confirm: return "Your grooming appointment has confirmed"
        case .reminder: return "Hi! You have grooming appointment tommorrow"
        case .completeGrooming: return "Your pet is ready for pick up in 20 mins"
            
        }
    }
}
