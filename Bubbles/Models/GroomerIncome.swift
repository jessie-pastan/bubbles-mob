//
//  GroomerIncome.swift
//  Bubbles
//
//  Created by Jessie P on 8/5/23.
//

import Foundation
import FirebaseFirestoreSwift

struct GroomerIncomeData : Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var groomerId: String
    var apptId: String
    var apptDate: Date
    var income: Int
}
