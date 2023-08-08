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
    var createdDate: Date
    var service: String
    var addOn: String
    var detail: String
    var groomBy: String
    var servicePrice: String
    var addOnPrice: String
    var groomerId: String
    var apptId: String
    var petId: String
    var apptDate: Date
    
    var totalPrice: Int {
        return Int(servicePrice + addOnPrice) ?? 0
    }
    
}

extension GroomingHistory {
    static let MOCK_HISTORIES : [GroomingHistory] = [
        
        .init(createdDate: Date(), service: "Bath and Blowdry", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "120", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123", apptDate: Date() ),
        .init(createdDate: Date(), service: "SpaBath", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "150", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123", apptDate: Date()),
        .init(createdDate: Date(), service: "SpaBath", addOn: "TeethBrush", detail: "TrimAll", groomBy: "DiDi", servicePrice: "150", addOnPrice: "20", groomerId: "123", apptId: "123", petId: "123", apptDate: Date()),

    ]
}
