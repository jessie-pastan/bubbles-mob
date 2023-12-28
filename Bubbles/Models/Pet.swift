//
//  Pet.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Pet: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var breed: String
    var age: String
    var weight: String
    var isDog: Bool
    var imageUrl: String?
    var vaccineExpireDate: Date
    var vaccineImageUrl: String?
    var ownerId: String
    var isMed: Bool
    var petMedication: String
    var groomingHistory: [GroomingHistory]?
    
    
}

extension Pet {
    static var MOCK_PETS : [Pet] = [
        .init(id: NSUUID().uuidString, name: "Candy", breed: "Maltese", age: "11", weight: "3", isDog: true, vaccineExpireDate: Date(), ownerId: "", isMed: false, petMedication: "None")
    ]
    
}
