//
//  GroomerAlalyticViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 8/8/23.
//

import Foundation
import Firebase

@MainActor
class GroomerAnalyticViewModel: ObservableObject {
    @Published var sevendayBookingData = [BookingData]()
    
    func uploadSevendayBookingData() async throws {
        var monAppt = 0, tueAppt = 0, wedAppt = 0, thuAppt = 0, friAppt = 0, satAppt = 0, sunAppt = 0
        //delete old data
        try await deleteSevendayBookingData()
        //fetch new 7day appt
        var sevendayAppt = try await self.fetchSevendayAppt()
        
        sevendayAppt.forEach { appt in
            switch appt.dayOfWeek {
            case "Mon":
                monAppt += 1
            case "Tue":
                tueAppt += 1
            case "Wed":
                wedAppt += 1
            case "Thu" :
                thuAppt += 1
            case "Fri" :
                friAppt += 1
            case "Sat" :
                satAppt += 1
            case "Sun" :
                sunAppt += 1
            default :
                return
            }
        }
        
        let objects = [BookingData(bookings: CGFloat(monAppt), day: "Mon"),
                       BookingData(bookings: CGFloat(tueAppt), day: "Tue"),
                       BookingData(bookings: CGFloat(wedAppt), day: "Wed"),
                       BookingData(bookings: CGFloat(thuAppt), day: "Thu"),
                       BookingData(bookings: CGFloat(friAppt), day: "Fri"),
                       BookingData(bookings: CGFloat(satAppt), day: "Sat"),
                       BookingData(bookings: CGFloat(sunAppt), day: "Sun")]
        
        //insert new data
        for objectData in objects {
            //encode swift object to json
            guard let encodeData = try? Firestore.Encoder().encode(objectData) else { return }
            //insert in firestore
            let _ = try await Firestore.firestore().collection("sevendayBookingData").addDocument(data: encodeData)
        }
    }
    
    
    func fetchSevendayAppt() async throws -> [Appointment] {
        let currentDate = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!
        guard let uid = AuthService.shared.currentUser?.id else { return [Appointment]()}
        //fetch 7 days schedule
        let snapshots =  try await Firestore.firestore().collection("appointments").whereField("groomerId", isEqualTo: uid).whereField("dueDate", isGreaterThan: sevenDaysAgo ).getDocuments()
        return snapshots.documents.compactMap { (try? $0.data(as: Appointment.self)) }
        
    }
    
    func deleteSevendayBookingData() async throws {
        let snapshots = try await Firestore.firestore().collection("sevendayBookingData").getDocuments()
        for doc in snapshots.documents {
            try await doc.reference.delete()
            print("Document deleted successfully.")
        }
    }
    

    func fetchSevendayBookingData() async throws {
        let snapshots = try await Firestore.firestore().collection("sevendayBookingData").getDocuments()
        self.sevendayBookingData = try snapshots.documents.compactMap({try $0.data(as: BookingData.self ) })
    }
    
    
    
}
