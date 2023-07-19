//
//  NotificationViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/15/23.
//

import Foundation
import Firebase

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    func fetchNotifications(){
        
    }
    
    func uploadNotification(toUid uid: String, type: NotificationType){
        guard let user = AuthService.shared.currentUser else { return }
        let userId = user.id
        let data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": user.id ,
                                   "type": type.rawValue] // upload only raw value of enum in Firebase
        
        COLLECTION_NOTIFICATIONS.document(userId).collection("user-notifications").addDocument(data: data)
                            
    }
    
}
