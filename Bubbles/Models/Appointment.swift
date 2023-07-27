//
//  Appiontment.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Appointment: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var store: String
    var service: String
    var addOnService: String
    var groomer: String
    var dueDate: Date
    var time: String
    var timeDate: Date?
    var note: String?
    var ownerId: String
    var petName: String
    var groomerId: String
    var dateCreated: Date
    var isDone = false 
}

extension Appointment {
    static var MOCK_APPOINTMENT  : Appointment {
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "BasicBath", addOnService: "None", groomer: "Lisa", dueDate: Date(), time: "2.00pm", ownerId: "123", petName:  "Hachi", groomerId: "user111", dateCreated: Date() )
    }
}


