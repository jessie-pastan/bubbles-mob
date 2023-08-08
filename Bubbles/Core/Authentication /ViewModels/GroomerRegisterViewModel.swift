//
//  GroomerRegisterViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import Foundation
import Firebase
import FirebaseAuth

@MainActor
class GroomerRegisterViewModel: ObservableObject {
    
    @Published var userName = ""
    @Published var password = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var isGroomer = true
    @Published var groomingStoreId = ""
    @Published var groomingStoresList = [Store]()
    
    init()  {
        Task {
            self.groomingStoresList = try await UserService.fetchAllStores()
        }
   }
    
    func registerGroomer() async throws {
       
        try await AuthService.shared.createUser(email: email, password: password, userName: userName, phoneNumber: phoneNumber, isGroomer: isGroomer, groomingStoreId: groomingStoreId)
        try await createTimeslot()
       
    }
    
  
    
   private func createTimeslot() async throws {
        guard let uid =  AuthService.shared.currentUser?.id else { return }
       //guard let uid = Auth.auth().currentUser?.uid else { return }
        //time slots
        let timeSlots = [ TimeSlot(id: NSUUID().uuidString, timeString: "10 AM", isBooked: false),
                          TimeSlot(id: NSUUID().uuidString, timeString: "11 AM", isBooked: false),
                          TimeSlot(id: NSUUID().uuidString, timeString: "12 PM", isBooked: false),
                          TimeSlot(id: NSUUID().uuidString, timeString: "1 PM", isBooked: false),
                          TimeSlot(id: NSUUID().uuidString, timeString: "2 PM", isBooked: false)
                        ]
        let db = Firestore.firestore()
        
        // Define the start date
        let startDate = Date() // Use any desired start date
        
        // Define the calendar and date components
        let calendar = Calendar.current
       var dateComponents = DateComponents()
        
        // Loop through 365 days and generate the dates
        for day in 0..<365 {
            // Add the day component to the start date
            dateComponents.day = day
            let generatedDate = calendar.date(byAdding: dateComponents, to: startDate)!
            
            
            let dueDate = Schedule(date: generatedDate, timeSlots: timeSlots, isFullBooked: false, compensate: 0)
              //encode swift object to json
            guard let encodeDueDate = try? Firestore.Encoder().encode(dueDate) else { return }
            // Store the generated date in Firebase Firestore
           let _ =  try await db.collection("users").document(uid).collection("schedules")
                .addDocument(data: encodeDueDate)
        }
    }
    
    
    
}
