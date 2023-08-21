//
//  StoreCategory.swift
//  Bubbles
//
//  Created by Jessie P on 8/20/23.
//

import Foundation

struct StoreCategory: Identifiable {
    var id: Int
    var title: String
    var icon: String
}

extension StoreCategory {
    static let categories: [StoreCategory] = [
        .init(id: 1, title: "Dog Grooming", icon: "dog"),
        .init(id: 2, title: "Cat Grooming", icon: "happycat"),
        .init(id: 3, title: "Store Near Me", icon: "pin")
    ]
}
