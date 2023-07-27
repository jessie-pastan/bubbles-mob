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
    @Published var timeDate = Date()
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
        guard let uid = AuthService.shared.currentUser?.id else { return }
        self.convertTimeStringtoDate(timeString: selectedTime)
        
        
        let appt = Appointment(id: NSUUID().uuidString,
                               store: store,
                               service: selectedService,
                               addOnService: selectedAddOnService,
                               groomer: selectedGroomerName,
                               dueDate: selectedDate,
                               time: selectedTime,
                               timeDate: timeDate,
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
    
    func addGroomerBooking(bookingDate: Date, groomerId: String) async throws {
        var docId = ""
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let lastApptId = try await ScheduleManager.queryLastApptId(uid: uid)
        
        //fetch all booking of this groomer and check if date has created ?
        let allBookings = try await ScheduleManager.fetchAllGroomerBooking(groomerId: groomerId)
        
        if !allBookings.isEmpty{ 
            allBookings.forEach { booking in
                if booking.date.formatted(date: .abbreviated, time: .omitted) == bookingDate.formatted(date: .abbreviated, time: .omitted) {
                    docId = booking.id ?? ""
                
                    // if booking date already exist, add lastApptId in array
                    Task{
                        try await Firestore.firestore().collection("users").document(groomerId).collection("bookings").document(docId).updateData([ "bookingsId" : FieldValue.arrayUnion([lastApptId]) ])
                    }
                  }
                }
            
        }else{
            
            //if "bookings" is empty create new booking with date and [apptId] in it
            let groomerBooking = GroomerBooking(date: bookingDate, bookingsId: [lastApptId])
            //encode swift object to json
            guard let encodeUser = try? Firestore.Encoder().encode(groomerBooking) else { return }
            //insert in firestore\
            Task{
                try await Firestore.firestore().collection("users").document(groomerId).collection("bookings").addDocument(data: encodeUser)
            }
        }
    }
    
    func convertTimeStringtoDate(timeString: String) {
        if let time = ConvertTime.convertTimeStringToTimeOnly(timeString: timeString) {
            self.timeDate = time
        }
        
    }
}
