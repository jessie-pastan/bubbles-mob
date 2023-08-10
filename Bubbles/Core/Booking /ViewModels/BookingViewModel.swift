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
    @Published var groomerSchedule = [Schedule.MOCK_selectedDateAndTime]
    
    @Published var availbleSlots = [TimeSlot]()
    @Published var bookedSlots = [TimeSlot]()
    
    @Published var isSlotFull = false
    @Published var isTakeDayOff = false
    
    func updateData() async throws {
        
        guard let uid = AuthService.shared.currentUser?.id else { return }
        self.convertTimeStringtoDate(timeString: selectedTime)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E" // "E" represents the abbreviated day name (e.g., Sun, Mon, etc.)

        let dayOfWeek = DayOfWeek(rawValue: dateFormatter.string(from: selectedDate)) ?? .sunday
        
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
                               isDone: false,
        reminderSent: false,
        clientConfirmed: false,
                               dayOfWeek: dayOfWeek)
        //encode swift object to json
        guard let encodeAppt = try? Firestore.Encoder().encode(appt) else { return }
        //insert in firestore
        let _ = try await Firestore.firestore().collection("appointments").addDocument(data: encodeAppt)
    }
    
    func updateSlots(items: [Schedule], timeSlotString: String, groomerId: String) async throws {
        try await ScheduleManager.markSlotBooked(items: items, timeSlotString: timeSlotString, groomerId: groomerId)
    }
    
    func fetchPets() async throws {
        guard let uid = AuthService.shared.currentUser?.id else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("pets").getDocuments()
        self.pets = snapshot.documents.compactMap({try? $0.data (as: Pet.self)})
    }
     
    
    func fetchStoreServices(storeId: String) async throws {
        self.storeServices = try await StoreManager.fetchStoreServices(storeId: storeId)
    }
    
    func fetchGroomers(storeId: String) async throws {
        self.groomers = try await StoreManager().queryGroomers(storeId: storeId)
    }
    
    func fetchGroomerSchedule(groomerId: String, selectDate: Date) async throws {
        self.groomerSchedule = try await ScheduleManager.queryScheduleByselectDate(groomerId: selectedGroomerId, selectDate: selectDate)
            print(self.groomerSchedule)
        }
    
    
    func vertifyTakeDayOff(schedules: [Schedule]) -> Bool {
        //verify if that schedule set as day off?
        guard let schedule = schedules.first else { return false}
            if schedule.isFullBooked == true {
                print(schedule.isFullBooked)
                return true
            }
            return false
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
    
 
    func convertTimeStringtoDate(timeString: String) {
        if let time = ConvertTime.convertTimeStringToTimeOnly(timeString: timeString) {
            self.timeDate = time
        }
        
    }
}
