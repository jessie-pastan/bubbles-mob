//
//  UserService.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
import FirebaseAuth
import Firebase

struct UserService {
    static func fethUserData(uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    static func fethUpdatedAppoinmet(uid: String) async throws -> Appointment {
        let snapshot = try await Firestore.firestore().collection("appointments").document(uid).getDocument()
        return try snapshot.data(as: Appointment.self)
    
    }
    
}


