//
//  ApptViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/26/23.
//

import Foundation
import FirebaseAuth
import Firebase

@MainActor
class ApptViewModel : ObservableObject {
    @Published var appts = [Appointment]()
    @Published var sortedAppts = [Appointment]()
    @Published var selectedAppt: Appointment?
    
    
    //@Published var text = ""
    
    
    //@Published var updatedAppt: Appointment?
    
    init() {
        Task{
            try await fetchAppt()
        }
    }
    
    func fetchAppt() async throws {
        self.appts = try await UserService.fetchUserAppts()
        self.sortedAppts = SortedTime.sortedItemsByDayAndTime(appts: appts)
    }
    

   
    
    /*
    func fetchUpdatedAppt(appt: Appointment) async throws {
        let snapshot =  try await Firestore.firestore().collection("appointments").document(appt.id ?? "").getDocument()
        self.updatedAppt = try snapshot.data(as: Appointment.self)
        
    }
    */
}
