//
//  Notification.swift
//  Bubbles
//
//  Created by Jessie P on 7/15/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct Notification : Codable, Identifiable {
    @DocumentID var id: String?
    var timeStamp: Date
    var type: NotificationType
    var groomerId: String // uid of groomer who send noification
    var userName: String// groomer userName
    var petName: String
    var store: String
    var date: Date
    var time: String
    var clientId: String
    var apptId: String
}

enum NotificationType: Int, Codable {
   
    case reminder // raw value 0
    case completeGrooming// raw value 1

    
    var notificationMessage: String {
        switch self {
        case .reminder: return "Woof! Kindly reminder for upcoming grooming appointment"
        case .completeGrooming: return "is ready for pick up in 15 minutes"
            
        }
    }
}
