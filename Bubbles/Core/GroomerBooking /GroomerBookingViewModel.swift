//
//  GroomerBookingViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/27/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


@MainActor
class GroomerBookingViewModel : ObservableObject {
    @Published var date = Date()
    @Published var appts = [Appointment]()
    @Published var sortedAppts = [Appointment]()
    
    @Published var schedules =  [Schedule]()
    @Published var schedule: Schedule?
    @Published var isTakeDayOff = false
    @Published var allSchedules = [Schedule]()
    
   
    func fetchTodayBookings(date: Date) async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let snapshots = try await Firestore.firestore().collection("appointments").whereField("groomerId", isEqualTo: uid).whereField("dueDate", isGreaterThanOrEqualTo: startOfDay).whereField("dueDate", isLessThan: endOfDay).getDocuments()
        self.appts = snapshots.documents.compactMap({try? $0.data(as: Appointment.self)})
        sortedTime(appts: self.appts)
    }
    
    func sortedTime(appts: [Appointment]){
        self.sortedAppts = SortedTime.clockwiseSortedItems(appts: appts)
    }
    
    func updateDone(item : Appointment) async throws {
        var copyItem = item
        copyItem.setDone()
        // update done appt in firebase
        try Firestore.firestore().collection("appointments").document(copyItem.id ?? "").setData(from:copyItem)
    }
    
    
    func updateDayoffToggleTrue(schedule: Schedule) async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        var copyItem = schedule
        copyItem.markAsFullBooked(true)
        try Firestore.firestore().collection("users").document(uid).collection("schedules").document(schedule.id ?? "").setData(from: copyItem)
        print("DeBuG:Updated isFullBook to true")
    }
    
  
    
    
    func updateDayoffToggleFalse(schedule: Schedule) async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        var copyItem = schedule
     
        copyItem.markAsFullBooked(false)
        try Firestore.firestore().collection("users").document(uid).collection("schedules").document(schedule.id ?? "").setData(from: copyItem)
        print("DeBuG:Updated isFullBook to false")
    }
  
    func fetchSelectedSchedule(date: Date) async throws {
        
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        //fetch a selected schedule
        let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").whereField("date", isGreaterThanOrEqualTo: startOfDay).whereField("date", isLessThan: endOfDay).getDocuments()
        self.schedules = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
        print(self.schedules)
        print(self.schedules.count)
        if let schedule = self.schedules.first {
            self.isTakeDayOff = schedule.isFullBooked
            self.schedule = schedule
            
            print(self.schedule ?? Schedule.MOCK_selectedDateAndTime)
            print(self.isTakeDayOff)
        }
    }
        
    func fetchAllSched() async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").getDocuments()
        self.allSchedules = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
        print(self.allSchedules.count)
    }
    
      
        
    
}
