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
    var user : User
    @FirestoreQuery var appts: [Appointment]
    
    init(user: User) {
        self.user = user
        self._appts = FirestoreQuery(collectionPath: "users/\(user.id)/appointments")
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
                //try await UserService.fetchUpdatedAppoinment(uid: Auth.auth().currentUser?.uid ?? "k2gnAeKHyKNyOfaQ2jXc9esjk3Y2")
            }
        }
    }
    
}
struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView(user: User.MOCK_USERS[0])
    }
}
