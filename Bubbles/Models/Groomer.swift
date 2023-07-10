//
//  Groomer.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import Foundation
struct Groomer: Codable, Identifiable {
    let id: String
    var name: String
    var bio: String
    var imageUrl: String?
}


extension Groomer {
    static let groomers: [Groomer] = [
        .init(id: "1", name: "Lisa", bio: "jdf;sajdgkadf"),
        .init(id: "2", name: "Rose", bio: "adjfj;saldjg;dslf"),
        .init(id: "3", name: "Jenny", bio: "sjfldkjf;sadjf;"),
        .init(id: "4", name: "Jisoo", bio: "djf;dsjg;sdjfsla")
    ]
}
