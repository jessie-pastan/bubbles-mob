//
//  Price.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation

struct GroomingService: Codable, Identifiable, Hashable {
    let id: String
    var item: String
    var price: Int
}

extension GroomingService {
    static var MOCK_GROOMIMGSERVICE: [GroomingService] = [
        .init(id: NSUUID().uuidString, item: "Basic Bath and Blow Dry", price: 100),
        .init(id: NSUUID().uuidString, item: "Spa Bath and Blow Dry", price: 150),
        .init(id: NSUUID().uuidString, item: "Full Grooming with Scissor Styling", price: 200),
        .init(id: NSUUID().uuidString, item: "Teeth Brush", price: 20),
        .init(id: NSUUID().uuidString, item: "Detangle", price: 50)
    ]
    
}
