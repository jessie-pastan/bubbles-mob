//
//  GroomerNoteViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/29/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase
@MainActor
class GroomerNoteViewModel: ObservableObject {
    @Published var text = ""
    @Published var user: User?
    
    
    init(){
        Task{
             try await findUser()
            
        }
    }
    
    func findUser()async throws {
        self.user = AuthService.shared.currentUser
    }
   
    func fetchUpdateGroomerNote(appt : Appointment) async throws {
        let snapshot =  try await Firestore.firestore().collection("appointment").document(appt.id ?? "").getDocument()
        let _ = try snapshot.data(as: Appointment.self)
    }
     
    
    func uploadGroomerNote(appt: Appointment) async throws {
        guard let user = AuthService.shared.currentUser  else { return }
        
        let data : [String : Any] = [ "groomerNote" : ["date": Date(),
                                      "groomer": user.userName,
                                      "text" : self.text,
                                      "apptId" : appt.id as Any ]]
        
        
        
        let _ = try await Firestore.firestore().collection("appointments").document(appt.id ?? "").setData(data, merge:  true)
        
        
        
    }
    
    
}
