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
    
    
    init() {
        Task{
           try await fetchNotifications()
        }
    }
    
    func fetchNotifications() async throws  {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let snapshots =  try await Firestore.firestore().collection("notifications").document(uid).collection("user-notifications").order(by: "timeStamp", descending: true).getDocuments()
        self.notifications = snapshots.documents.compactMap({try? $0.data(as: Notification.self)})
            print(self.notifications)
        }
       
    
    
    func uploadNotification(toUid uid: String, type: NotificationType, appt: Appointment) {
        guard let user  = AuthService.shared.currentUser else { return }
        let userId = user.id 
        let data: [String: Any] = ["timeStamp": Date(),
                                   "groomerId": userId,
                                   "type": type.rawValue, //upload rawValue to firebase 
                                   "userName": user.userName,
                                   "petName" : appt.petName,
                                   "date": appt.dueDate,
                                   "time": appt.time,
                                   "store": appt.store,
                                   "clientId": uid]
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
        print("DEBUG: Uploaded Notification")
                            
    }
    
}
