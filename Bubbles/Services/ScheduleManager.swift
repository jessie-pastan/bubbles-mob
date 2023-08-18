//
//  ScheduleManager.swift
//  Bubbles
//
//  Created by Jessie P on 7/20/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class ScheduleManager {
    
    //Display regular calender picker in UI
    
    // when user tap on a specific date (dd-mm-yy)
    // query  that day in data base using groomerId and date that user are selecting
    // verify that date still avialable by checking
    // schedule.isFullbooked == false
    // loop through [timeSlot] of that day
    // for timeSlot.isBooked == false
    // Display that avialable timeslot
    // Else Display to user that schedule has fullbooked
    
        //no use
        static func verifyDateAsFullBooked(schedules: [Schedule])->Bool {
            var timeSlotBooked = 0
            var allTimeSlots = 0
            for schedule in schedules {
                allTimeSlots = schedule.timeSlots.count
                (schedule.timeSlots).forEach { timeSlot in
                        if timeSlot.isBooked {
                            timeSlotBooked += 1
                    }
                }
            }
            return timeSlotBooked == allTimeSlots
                
        }
        // no use
        static func markDateFullBooked(items: [Schedule], groomerId: String) async throws  {
            let isFullbooked = verifyDateAsFullBooked(schedules: items)
            let itemId = ""
            for item in items {
                var copyItem = item
                copyItem.markAsFullBooked(isFullbooked)
                let _ = try? Firestore.firestore().collection("users").document(groomerId).collection("schedules").document(itemId).setData(from: copyItem)
            }
        }
                                                                                                    
        //Mark Booked status of timeslot
        static func markSlotBooked(items: [Schedule], timeSlotString: String, groomerId: String) async throws {
            if let schedule = items.first{
                let scheduleId = schedule.id ?? "123"
                
                var timeSlotId = "123"
                let newTimeSlot = TimeSlot(id: NSUUID().uuidString, timeString: timeSlotString, isBooked: true)

                (schedule.timeSlots).forEach { timeslot in
                    if timeslot.timeString == timeSlotString {
                        timeSlotId = timeslot.id
                    }
                }
                // find timeslot that selected by user
                let db = Firestore.firestore()
                let ref = db.collection("users").document(groomerId).collection("schedules").document(scheduleId)
                
                let snapshot = try await ref.getDocument()
                if var schedule  = try? snapshot.data(as: Schedule.self) {
                    
                    // Filter out the TimeSlot with the given timeSlotId and remove timeSlot
                    schedule.timeSlots.removeAll { $0.id == timeSlotId }
                    // and add updated new timeSlot with isbooked: true
                    schedule.timeSlots.append(newTimeSlot)
                    // insert object in collection
                    try ref.setData(from: schedule)
                }
            
            }
        }
       
        // Fetch 365 day of schedule of a groomer
        static func queryAllGroomerSchedule(groomerId: String) async throws -> [Schedule] {
            var schedules = [Schedule]()
            // Fetch schedule documents for the groomer
            let snapshot = try await Firestore.firestore().collection("users").document(groomerId).collection("schedules").getDocuments()
            let documents = snapshot.documents
            for doc in documents {
                let schedule = try doc.data(as:Schedule.self)
                schedules.append(schedule)
            }
            return schedules
        }
        
        // filter schedule with selected date
        static func queryScheduleByselectDate(groomerId: String, selectDate: Date) async throws -> [Schedule] {
            var targetSchedule = [Schedule]()
            let schedules = try await queryAllGroomerSchedule(groomerId: groomerId)
            for schedule in schedules {
                let groomerDateString = (schedule.date.formatted(date: .abbreviated, time: .omitted))
                let selectDateString = selectDate.formatted(date: .abbreviated, time: .omitted)
                if groomerDateString == selectDateString {
                    targetSchedule.append(schedule)
                }
            }
            //return 1 schedule in array of schedule
            return targetSchedule
        }
    
    
}
