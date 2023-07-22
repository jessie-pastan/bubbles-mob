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
    
    @Published var selectedService = "Select Service"
    @Published var selectedAddOnService = "Select Add On"
    // selected groomer is User Id String
    @Published var selectedGroomerId = "Select Groomer"
    @Published var selectedGroomerName = ""
    @Published var selectedDate = Date()
    @Published var selectedTime = "Select Time"
    @Published var note = ""
    @Published var store = ""
    @Published var petName = "Select Pet"
    @Published var petId = ""
    
    @Published var pets = [Pet]()
    @Published var storeServices = [GroomingService]()
    @Published var groomers = [User]()
    @Published var groomerSchedule = [Schedule]()
    @Published var groomerSlots = [TimeSlot]()
    
   
    
    init(){
        Task{
            pets = try await fetchPets()
        }
    }
    
    func updateData() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let appt = Appointment(id: NSUUID().uuidString,
                               store: store,
                               service: selectedService,
                               addOnService: selectedAddOnService,
                               groomer: selectedGroomerName,
                               dueDate: selectedDate,
                               time: selectedTime,
                               note: note,
                               ownerId: uid,
                               petName: petName,
                               groomerId: selectedGroomerId,
                               dateCreated: Date(),
                               isDone: false)
        
        //encode swift object to json
        guard let encodeUser = try? Firestore.Encoder().encode(appt) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("users").document(uid).collection("appointments").addDocument(data: encodeUser)
    }
    
    func fetchPets() async throws -> [Pet]{
            let snapshot = try await Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "").collection("pets").getDocuments()
            return snapshot.documents.compactMap({try? $0.data (as: Pet.self)})
        }
        
    func fetchStoreServices(storeId: String) async throws {
        self.storeServices = try await StoreManager.fetchStoreServices(storeId: storeId)
    }
    
    func fetchGroomers(storeId: String) async throws {
        self.groomers = try await StoreManager().queryGroomers(storeId: storeId)
    }
    
    func fetchGroomerSchedule(groomerId: String, selectDate: Date)async throws {
        self.groomerSchedule = try await ScheduleManager.queryScheduleByselectDate(groomerId: selectedGroomerId, selectDate: selectDate)
    }
    
    func fetchSelectedGroomer(groomerId: String) async throws {
        let snapshot = try await Firestore.firestore().collection("users").document(groomerId).getDocument()
        let groomer = try snapshot.data(as: User.self)
        self.selectedGroomerName = groomer.userName
    }
    
    
    func showGroomerSlots(schedules: [Schedule]) {
        var timeSlots = [TimeSlot]()
        //extract schedule out of array
        if let schedule  = schedules.first {
            (schedule.timeSlots).forEach { timeSlot in
                timeSlots.append(timeSlot)
            }
            self.groomerSlots = timeSlots
        }
    }
}
    
    

