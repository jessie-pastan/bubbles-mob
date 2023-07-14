//
//  Groomer.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import Foundation
struct Groomer: Codable, Identifiable, Hashable {
    let id: String
    var name: String
    var bio: String
    var imageUrl: String?
    var storeId: String
    var bookingId: String?
}


extension Groomer {
    static let groomers: [Groomer] = [
        .init(id: "1", name: "Lisa", bio: "Lisa has special grooming technique with her soft and gentle hands for your furbabies." ,imageUrl: "shop4", storeId: "1"),
        .init(id: "2", name: "Rose'", bio: "With 15 years of grooming experinece, Your furbabie will be in a good hand of Rose'!" ,imageUrl: "shop3", storeId: "1"),
        .init(id: "3", name: "Jenny", bio: "'I Love grooming as puppy love their toys!'", imageUrl: "shop12", storeId: "1"),
        .init(id: "4", name: "Jisoo", bio: "Graduated from grooming school in Korea , Your furbabie will look great with jisoo's magic!" , imageUrl: "groomer1", storeId: "1")
    ]
}
