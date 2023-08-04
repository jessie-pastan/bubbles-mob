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
    @Published var appt: Appointment?
    
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
                                   "clientId": uid,
                                   "apptId" : appt.id ?? ""]
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
        print("DEBUG: Uploaded Notification")
                            
    }
    
    
    func fetchAppt(noti: Notification) async throws {
        let apptId = noti.apptId
        let snapshot = try await Firestore.firestore().collection("appointments").document(apptId).getDocument()
        self.appt = try snapshot.data(as: Appointment.self)
    }
    
    
    
    func confirmAppt(item : Appointment) async throws {
            var copyItem = item
            copyItem.sentConfirm()
            // update done appt in firebase
            try Firestore.firestore().collection("appointments").document(copyItem.id ?? "").setData(from:copyItem)
        }
        
   
    
}
