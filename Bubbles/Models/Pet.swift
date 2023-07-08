//
//  Pet.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import Foundation
struct Pet: Codable, Identifiable {
    let id: String
    var name: String
    var breed: String
    var age: String
    var weight: String
    var isDog: Bool
    var imageUrl: String?
    var vaccineExpireDate: TimeInterval
    var vaccineImageUrl: String?
    var ownerId: String
    var isMed: Bool
    var petMedication: String
}

extension Pet {
    static var MOCK_PETS : [Pet] = [
        .init(id: NSUUID().uuidString, name: "Candy", breed: "Maltese", age: "11", weight: "3", isDog: true, vaccineExpireDate: Date().timeIntervalSince1970, ownerId: "", isMed: false, petMedication: "None")
    ]
    
}
