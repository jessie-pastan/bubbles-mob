//
//  GroomingHistory.swift
//  Bubbles
//
//  Created by Jessie P on 8/4/23.
//

import Foundation
import FirebaseFirestoreSwift
struct GroomingHistory: Codable,Identifiable,Hashable {
    @DocumentID var id: String?
    var date: Date
    var service: String
    var addOn: String
    var detail: String
    var groomBy: String
    var servicePrice: String
    var addOnPrice: String
    var groomerId: String
    var apptId: String
    var petId: String
    
}

extension GroomingHistory {
    static let MOCK_HISTORIES : [GroomingHistory] = [
        
        .init(date: Date(), service: "Bath and Blowdry", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "120", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123"),
        .init(date: Date(), service: "SpaBath", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "150", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123"),
        .init(date: Date(), service: "SpaBath", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "150", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123"),

    ]
}
