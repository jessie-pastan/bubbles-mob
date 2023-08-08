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
        let data = GroomingHistory(createdDate: Date(), service: appt.service, addOn: appt.addOnService, detail: self.text , groomBy: appt.groomer , servicePrice: self.servicePrice, addOnPrice: self.addOnPrice, groomerId: appt.groomerId, apptId: appt.id ?? "", petId: self.pet?.id ?? "", apptDate: appt.dueDate)
        //encode swift object to json
        guard let encodeData = try? Firestore.Encoder().encode(data) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("petHistories").addDocument(data: encodeData)
    }
    
    func fetchPetHistory(pet: Pet) async throws {
        let snapShot  = try await Firestore.firestore().collection("petHistories").whereField("petId", isEqualTo: pet.id ?? "").getDocuments()
        self.petHistories = snapShot.documents.compactMap({ try? $0.data(as: GroomingHistory.self)})
    }
    
    func updateGroomerIncomeData(servicePrice: String, addOnPrice: String, appt: Appointment) async throws {
        if let servicePrice = Int(servicePrice) {
            if let addOnPrice = Int(addOnPrice) {
                let totalPrice = servicePrice + addOnPrice
                guard let uid = AuthService.shared.currentUser?.id else { return }
                let data = GroomerIncomeData(groomerId: uid, apptId: appt.id ?? "" , apptDate: appt.dueDate, income: totalPrice)
                //encode swift object to json
                guard let encodeData = try? Firestore.Encoder().encode(data) else { return }
                //insert in firestore
                let _ = try await Firestore.firestore().collection("groomerIncomeData").addDocument(data: encodeData)
                
            }
        }
        
        
    }
    
    
    func updateGroomerCompensate(servicePrice: String, addOnPrice: String, appt: Appointment) async throws {
        if let servicePrice = Int(servicePrice) {
            if let addOnPrice =  Int(addOnPrice) {
                let totalPrice = servicePrice + addOnPrice
                //find schedule that according to appt day
                guard let uid = AuthService.shared.currentUser?.id else { return }
                let calendar = Calendar.current
                let startOfDay = calendar.startOfDay(for: appt.dueDate)
                let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
                //fetch a selected schedule
                let snapshots =  try await Firestore.firestore().collection("users").document(uid).collection("schedules").whereField("date", isGreaterThanOrEqualTo: startOfDay).whereField("date", isLessThan: endOfDay).getDocuments()
                let schedules = snapshots.documents.compactMap { (try? $0.data(as: Schedule.self)) }
                print("Schedule[] according to appt date:\(schedules)")
                print("Schedule according to appt date: \(schedules.count)")
                guard let schedule = schedules.first else { return }
                
                let compensate = schedule.compensate
                let totalCompensate = Int(compensate) + Int(totalPrice)
                let data : [String : Any] = ["compensate" : totalCompensate as Any ]
                try await Firestore.firestore().collection("users").document(uid).collection("schedules").document(schedule.id ?? "").setData(data, merge: true)
                print("DEBUG: updateCompensate on date \(schedule.date.formatted(date: .abbreviated, time: .omitted)) Successfully")
            }
        }
    }
   
    
}
