//
//  PetDetailViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 8/3/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class PetDetailViewModel : ObservableObject {
    @Published var client: User?
    @Published var pet: Pet?
  
    func fetchClientfromAppt(appt: Appointment) async throws {
       
        let snapshot = try await Firestore.firestore().collection("users").document(appt.ownerId).getDocument()
        self.client = try snapshot.data(as: User.self)
    }
        
    func fetchPetOfAppt(appt: Appointment) async throws {
        let snapshots = try await Firestore.firestore().collection("users").document(appt.ownerId).collection("pets").whereField("name", isEqualTo: appt.petName).getDocuments()
        let pets = snapshots.documents.compactMap({ try? $0.data(as: Pet.self) })
        if let pet = pets.first {
            self.pet = pet
        }
        
    }
    
    
    
}
