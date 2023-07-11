//
//  Appiontment.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation

struct Appointment: Codable, Identifiable {
    
    let id: String
    var store: String
    var service: String
    var addOnService: String
    var groomer: String
    var date: TimeInterval
    var time: String
    var note: String?
    var ownerId: String
    var petName: String
}

extension Appointment {
    static var MOCK_APPOINTMENT  : Appointment {
        .init(id: NSUUID().uuidString, store: "PuppyPaws", service: "BasicBath", addOnService: "None", groomer: "Lisa", date: Date().timeIntervalSince1970, time: "2.00pm", ownerId: "123", petName:  "Hachi")
    }
}
