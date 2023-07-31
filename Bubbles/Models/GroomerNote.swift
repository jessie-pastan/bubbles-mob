//
//  History.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation
import FirebaseFirestoreSwift
struct GroomerNote: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var date: Date
    var groomer: String
    var groomingImageUrl: String?
    var text: String
    var apptId: String
    
}
