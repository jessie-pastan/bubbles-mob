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
    @Published var petHistories =  [GroomingHistory]()
    @Published var text = ""
    @Published var servicePrice = ""
    @Published var addOnPrice = ""
  
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
    
    
    func uploadPetHistory(appt: Appointment) async throws  {
        let data = GroomingHistory(date: Date(), service: appt.service, addOn: appt.addOnService, detail: self.text , groomBy: appt.groomer , servicePrice: self.servicePrice, addOnPrice: self.addOnPrice, groomerId: appt.groomerId, apptId: appt.id ?? "", petId: self.pet?.id ?? "")
        //encode swift object to json
        guard let encodeData = try? Firestore.Encoder().encode(data) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("petHistories").addDocument(data: encodeData)
    }
    
    func fetchPetHistory(pet: Pet) async throws {
        let snapShot  = try await Firestore.firestore().collection("petHistories").whereField("petId", isEqualTo: pet.id ?? "").getDocuments()
        self.petHistories = snapShot.documents.compactMap({ try? $0.data(as: GroomingHistory.self)})
    }
   
    
}
