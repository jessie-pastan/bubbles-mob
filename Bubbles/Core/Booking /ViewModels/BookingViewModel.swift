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
    // selected groomerId is User Id String
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
    @Published var availbleSlots = [TimeSlot]()
    @Published var bookedSlots = [TimeSlot]()
    
    @Published var isSlotFull = false
    
    
    
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
    
    func updateSlots(items: [Schedule], timeSlotString: String, groomerId: String) async throws {
        try await ScheduleManager.markSlotBooked(items: items, timeSlotString: timeSlotString, groomerId: groomerId)
    }
    
    // no use function
    func updateTimeSlot(schedules: [Schedule], groomerId: String, timeSlotString: String) {
        
        if let schedule = schedules.first {
            let  scheduleId =  schedule.id ?? ""
            let db = Firestore.firestore()
            let scheduleRef = db.collection("users").document(groomerId).collection("schedules").document(scheduleId)
            
            scheduleRef.getDocument { document, error in
                guard let document = document,
                      let schedule = try? document.data(as: Schedule.self),
                      var timeSlots = schedule.timeSlots.first(where: { $0.timeString == timeSlotString }) else {
                    print("Error fetching schedule or timeSlot data")
                    return
                }
                
                timeSlots.isBooked = true
                
                // Update the specific TimeSlot within the TimeSlots array
                if let index = schedule.timeSlots.firstIndex(where: { $0.timeString == timeSlotString }) {
                    var copySchedule = schedule
                    copySchedule.timeSlots[index] = timeSlots
                }
                
                // Write the updated Schedule back to Firestore
                do {
                    try scheduleRef.setData(from: schedule)
                } catch {
                    print("Error updating schedule: \(error.localizedDescription)")
                }
            }
        }
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
        var showSlots = [TimeSlot]()
        
        //extract schedule out of array
        if let schedule  = schedules.first {
            (schedule.timeSlots).forEach { timeSlot in
                if !timeSlot.isBooked {
                    showSlots.append(timeSlot)
                }else{
                    bookedSlots.append(timeSlot)
                }
            }
            self.availbleSlots = showSlots
        }
    }
    
    func checkSlotsFull(schedules: [Schedule] , bookedSlots : [TimeSlot])  {
        var allSlot = 0
        var slotBooked = 0
        if let schedule = schedules.first {
            allSlot = schedule.timeSlots.count
            slotBooked = bookedSlots.count
            
            if allSlot == slotBooked {
                self.isSlotFull = true
            }
        }
    }
}
