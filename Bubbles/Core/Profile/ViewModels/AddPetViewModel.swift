//
//  AddPetViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class AddPetViewModel : ObservableObject {
    @Published var petName = ""
    @Published var petBreed = ""
    @Published var petAge = ""
    @Published var petWeight = ""
    @Published var petMedication = ""
    @Published var expirationDate = Date()
    
    @Published var isDog = true
    @Published var isMed = false
    
    func updateData() async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let pet = Pet(id: NSUUID().uuidString, name: petName, breed: petBreed, age: petAge, weight: petWeight, isDog: isDog, vaccineExpireDate: expirationDate.timeIntervalSince1970, ownerId: uid, isMed: isMed, petMedication: petMedication)
        //encode swift object to json
        guard let encodeUser = try? Firestore.Encoder().encode(pet) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("users").document(uid).collection("pets").addDocument(data: encodeUser)
        
    }
    
    
    
}
