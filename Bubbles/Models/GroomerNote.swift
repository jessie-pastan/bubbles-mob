//
//  History.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation
struct GroomerNote: Codable, Identifiable {
    let id: String
    var date: TimeInterval
    var groomer: String
    var groomingImageUrl: String?
    var groomerNote: String
    var appintmentId: String
    
}
