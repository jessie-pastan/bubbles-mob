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
        let sevendayAppt = try await self.fetchSevendayAppt()
        
        sevendayAppt.forEach { appt in
            switch appt.dayOfWeek {
            case .monday:
                monAppt += 1
            case .tuesday:
                tueAppt += 1
            case .wednesday:
                wedAppt += 1
            case .thursday :
                thuAppt += 1
            case .friday :
                friAppt += 1
            case .saturday:
                satAppt += 1
            case .sunday:
                sunAppt += 1
            }
        }
        
        let objects = [BookingData(bookings: CGFloat(monAppt), day: .monday, dayInt: 1),
                       BookingData(bookings: CGFloat(tueAppt), day: .tuesday, dayInt: 2),
                       BookingData(bookings: CGFloat(wedAppt), day: .wednesday,dayInt: 3),
                       BookingData(bookings: CGFloat(thuAppt), day: .thursday, dayInt: 4),
                       BookingData(bookings: CGFloat(friAppt), day: .friday, dayInt: 5),
                       BookingData(bookings: CGFloat(satAppt), day: .saturday, dayInt: 6),
                       BookingData(bookings: CGFloat(sunAppt), day: .sunday, dayInt: 0)]
        
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
        
        let bookingData = try snapshots.documents.compactMap({try $0.data(as: BookingData.self ) })
        
        self.sevendayBookingData = bookingData.sorted { $0.dayInt < $1.dayInt }
        print(self.sevendayBookingData)
    }
    
    
    
}
