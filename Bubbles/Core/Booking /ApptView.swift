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
    
    @StateObject var viewModel = ApptViewModel()
    
    var body: some View {
        
        VStack{
            if !viewModel.appts.isEmpty {
                if let appts = viewModel.sortedAppts.filter({ $0.isDone == false}){
                    Text("Upcoming Appointments")
                        .font(.title2)
                        .bold()
                    ScrollView{
                        ForEach(appts) { appt in
                            VStack{
                                AppointmentViewRow(appt: appt)
                            }
                        }
                    }
                }
            }else{
                Text("No Upcomimg Appointment yet.")
            }
        }.onAppear {
            Task{
                try await viewModel.fetchAppt()
            }
            
            
        }
    }
}
    

struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView()
    }
}
