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
    static func fetchUserData(uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func fetchUserAppts() async throws -> [Appointment] {
        guard let uid = await AuthService.shared.currentUser?.id else { return [Appointment]()}
        let snapshot = try await Firestore.firestore().collection("appointments").whereField("groomerId", isEqualTo: uid).getDocuments()
        return snapshot.documents.compactMap({try? $0.data(as: Appointment.self)})
    }
    
    // no use
    static func fetchUpdatedAppoinment(uid: String) async throws -> Appointment {
        let snapshot = try await Firestore.firestore().collection("appointments").document(uid).getDocument()
        return try snapshot.data(as: Appointment.self)
    
    }
    
    static func fetchAllStores() async throws -> [Store]{
        let snapshot = try await Firestore.firestore().collection("stores").getDocuments()
        return snapshot.documents.compactMap({try? $0.data (as: Store.self)})
    }
    
    static func fetchAllUser() async throws -> [User]{
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap({try? $0.data (as: User.self)})
    }
    
   
    
}


