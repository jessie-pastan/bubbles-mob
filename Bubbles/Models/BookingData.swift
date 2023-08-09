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
    var bookings: CGFloat
    // day of week eg. "Mon", "Tue", "Wed"
    var day: String
}
