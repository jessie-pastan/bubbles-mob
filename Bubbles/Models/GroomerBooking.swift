//
//  GroomerBooking.swift
//  Bubbles
//
//  Created by Jessie P on 7/26/23.
//

import Foundation
import FirebaseFirestoreSwift
struct GroomerBooking: Codable, Identifiable, Hashable {
    @DocumentID var id : String?
    var date: Date
    var bookingsId: [String]?
   
}
