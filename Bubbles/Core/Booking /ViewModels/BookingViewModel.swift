//
//  BookingViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
class BookingViewModel : ObservableObject {
    
    @Published var selectedService = ""
    @Published var selectedAddOnService = ""
    @Published var selectedGroomer = ""
    @Published var selectedDate = Date()
    @Published var selectedTime = ""
    @Published var note = ""
    @Published var store = ""
    @Published var petName = "hachi"
    @Published var petId = ""
    
    //init(){
        //self.petId = findSelectedPet(petName: petName)
    //}
    
    
    func updateData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let appt = Appointment(id: NSUUID().uuidString, store: "", service: selectedService, addOnService: selectedAddOnService, groomer: selectedGroomer, date: selectedDate.timeIntervalSince1970, time: selectedTime, ownerId: uid, petName: petName)
        
        //encode swift object to json
        guard let encodeUser = try? Firestore.Encoder().encode(appt) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("users").document(uid).collection("appointments").addDocument(data: encodeUser)
    }
    
    //Todo: fix this function to find PetId from selected pet
    func findSelectedPet(pets: [Pet]) {
        for index in 0..<pets.count {
            let pet = pets[index]
            let petId = pet.id
            if pet.name == self.petName {
                self.petId = petId
                
            }
        }
   }
    
}
