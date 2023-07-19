//
//  SelectedDateAndTimeSlot.swift
//  Bubbles
//
//  Created by Jessie P on 7/17/23.
//

import Foundation
struct Schedule: Codable, Identifiable {
    let id: String
    var date: Date
    var timeSlots: [TimeSlot]
    var isFullBooked: Bool
    
    /*{
        var timeSlotBooked = 0
        
        (timeSlot).forEach { timeSlot in
            if timeSlot.isBooked {
                timeSlotBooked += 1
        }
    }
        return timeSlotBooked == timeSlot.count
    }
     */
}

struct TimeSlot: Codable, Identifiable {
    let id: String
    var time: TimeInterval?
    var timeString: String
    var isBooked: Bool
    var ApptId: String?
}






extension  Schedule {
    static let MOCK_selectedDateAndTime: Schedule  =
        .init(id: NSUUID().uuidString, date: Date(), timeSlots: TimeSlot.MOCK_timeSlot, isFullBooked: false)
}
    
extension TimeSlot {
    static let MOCK_timeSlot: [TimeSlot] = [
        .init(id: NSUUID().uuidString, time: Date().timeIntervalSince1970, timeString: "11 am", isBooked: false),
        .init(id: NSUUID().uuidString, time: Date().timeIntervalSince1970, timeString: "1 pm", isBooked: false),
        .init(id: NSUUID().uuidString, time: Date().timeIntervalSince1970, timeString: "2pm", isBooked: false)
    ]
}

