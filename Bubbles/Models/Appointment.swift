//
//  Appiontment.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation
import FirebaseFirestoreSwift


enum DayOfWeek: String, Codable {
    case sunday = "Sun"
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
}



struct Appointment: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var store: String
    var service: String
    var addOnService: String
    var groomer: String
    var dueDate: Date
    var time: String
    var timeDate: Date
    var note: String?
    var ownerId: String
    var petName: String
    var groomerId: String
    var dateCreated: Date
    var isDone = false
    var groomerNote : GroomerNote?
    var reminderSent = false
    var clientConfirmed = false
     
    var dayOfWeek : DayOfWeek
    
    
    
    mutating func setDone(){
        isDone = true
    }
    
    mutating func sentReminder(){
       reminderSent = true
    }
    
    mutating func sentConfirm(){
        clientConfirmed = true
    }
    
}

extension Appointment {
    static var MOCK_APPOINTMENT  : Appointment {
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "BasicBath", addOnService: "TeethBrush", groomer: "Lisa", dueDate: Date(), time: "2 PM", timeDate: Date(), ownerId: "123", petName:  "Hachi", groomerId: "user111", dateCreated: Date(), dayOfWeek: DayOfWeek(rawValue: "Mon") ?? .monday )
    }
}

extension Appointment {
    static var MOCK_APPOINTMENTS  : [Appointment] = [
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "BasicBath", addOnService: "Teeth Brush", groomer: "Lisa", dueDate: Date(), time: "11 AM", timeDate: Date(), ownerId: "123", petName:  "Hachi", groomerId: "user111", dateCreated: Date(), dayOfWeek: DayOfWeek(rawValue: "Tue") ?? .monday ),
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "FullGrooming", addOnService: "Nails cut", groomer: "Lisa", dueDate: Date(), time: "1 PM", timeDate: Date(), ownerId: "123", petName:  "Snowball", groomerId: "user111", dateCreated: Date(), dayOfWeek: DayOfWeek(rawValue: "Wed") ?? .monday ),
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "SpaBath", addOnService: "Detangle", groomer: "Lisa", dueDate: Date(), time: "2 PM", timeDate: Date(), ownerId: "123", petName:  "Mimi", groomerId: "user111", dateCreated: Date(), dayOfWeek: DayOfWeek(rawValue: "Fri") ?? .monday ),
        ]
}
