//
//  BookingData.swift
//  Bubbles
//
//  Created by Jessie P on 8/8/23.
//

import Foundation
import FirebaseFirestoreSwift

struct BookingData: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    //how  many booking time?
    var bookings: Int
    // on this day eg. "MON", "TUE"
    var day: String
    //
    var bookingDate: Date
    
}
