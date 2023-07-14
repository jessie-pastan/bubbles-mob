//
//  ApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ApptView: View {
    @FirestoreQuery var appts:  [Appointment]
    
    init() {
        self._appts =  FirestoreQuery(collectionPath: "users/\(Auth.auth().currentUser?.uid ?? "")/appointments")
    }
    var body: some View {
        
            List{
                Section("Upcoming Appiontment") {
                    if let firstAppt = appts.last {
                        AppointmentViewRow(appt: firstAppt)
                        Button {
                            
                        } label: {
                            ButtonView(title: "Edit Appoinment")
                            
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Cancle Appiontment")
                                .bold()
                                .frame(width: 350, height: 39)
                                .background(Color(.systemRed))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                           
                        }

                    }
                   

                }
                
            }
        
    }
}
struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView()
    }
}
