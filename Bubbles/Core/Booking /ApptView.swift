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
        VStack{
            List{
                Section("Upcoming Appiontment") {
                    if let appts = appts.filter({ $0.isDone == false}) {
                        ForEach(appts) { appt in
                            VStack{
                                AppointmentViewRow(appt: appt)
                                
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
                            }.padding(.bottom,40)
                            
                        }
                    }
                }
            }
        }.onAppear {
            Task{
               try await  UserService.fetchUpdatedAppoinment(uid: Auth.auth().currentUser?.uid ?? "")
            }
        }
    }
}
struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView()
    }
}
