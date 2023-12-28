//
//  ApptViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/26/23.
//

import Foundation
import FirebaseAuth
import Firebase

@MainActor
class ApptViewModel : ObservableObject {
    @Published var appts: [Appointment]?
    @Published var sortedAppts: [Appointment]?
    @Published var selectedAppt: Appointment?
    

    
    init() {
        Task{
            try await fetchAppt()
        }
    }
    
    func fetchAppt() async throws {
        self.appts = try await UserService.fetchUserAppts()
        self.sortedAppts = SortedTime.sortedItemsByDayAndTime(appts: appts ?? Appointment.MOCK_APPOINTMENTS)
    }
    
    func deleteAppt(appt: Appointment) async throws {
        try await Firestore.firestore().collection("appointments").document(appt.id ?? "").delete()
        print("DEBUG: deleted appt")
    }
    
   //after delete appt .. fetch groomer slot and update -> isbooked: false
    func updateFreeSlot(appt: Appointment) async throws {
        
        // Get the start and end Timestamps for the desired date
        let selectedDate = appt.dueDate
        let startOfDay = Timestamp(date: Calendar.current.startOfDay(for: selectedDate))
        let endOfDay = Timestamp(date: Calendar.current.date(byAdding: .day, value: 1, to: startOfDay.dateValue())!)

        let snapshot = try await Firestore.firestore().collection("users").document(appt.groomerId).collection("schedules").whereField("date", isGreaterThanOrEqualTo: startOfDay).whereField("date", isLessThan: endOfDay).getDocuments()
        let schedules = try snapshot.documents.compactMap({try $0.data(as: Schedule.self)})
        
        //if var make schedule object immutable
        if var schedule = schedules.first {
            let schudleId = schedule.id ?? ""
            var timeSlotId = ""
            let newTimeSlot = TimeSlot(id: NSUUID().uuidString, timeString: appt.time, isBooked: false)
            (schedule.timeSlots).forEach { timeSlot in
                if timeSlot.timeString == appt.time {
                    timeSlotId = timeSlot.id
                }
            }
            
            //removed timeSlot that Booked
            schedule.timeSlots.removeAll { $0.id == timeSlotId }
            //and update newSlot with isBooked: false
            schedule.timeSlots.append(newTimeSlot)
            //and insert new object in firebase
            try Firestore.firestore().collection("users").document(appt.groomerId).collection("schedules").document(schudleId).setData(from: schedule)
            print("DEBUG: updated FreetimeSlot")
            }
        
        }
    
   
}
