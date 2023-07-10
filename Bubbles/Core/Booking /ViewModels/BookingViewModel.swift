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
    @Published var selectedtime = ""
    @Published var note = ""
    @Published var store = ""
    @Published var petName = "hachi"
    @Published var pet: Pet?
    
    @Published var petId = ""
    
    //init(){
        
        
        //self.petId = findSelectedPet(petName: petName)
    //}
    
    
    func updateData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let appt = Appointment(id: NSUUID().uuidString, store: "", service: selectedService, addOnService: selectedAddOnService, groomer: selectedGroomer, date: selectedDate.timeIntervalSince1970, time: selectedtime, ownerId: uid, petId: petId)
        
        //encode swift object to json
        guard let encodeUser = try? Firestore.Encoder().encode(appt) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("users").document(uid).collection("appointments").addDocument(data: encodeUser)
    }
    
    func findSelectedPet(petName: String) -> String {
        var petId = ""
        //for pet in pets {
            //if pet.name == self.petName{
                //petId = pet.id
           // }
        //}
        return petId
   }
    
}
