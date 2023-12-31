//
//  ApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct ApptView: View {
    
    @StateObject var viewModel = ApptViewModel()
    
    var body: some View {
      
        VStack {
            if !(viewModel.appts?.isEmpty ?? true) {
                Text("Your Upcoming Appointment").bold()
                if let appts = viewModel.sortedAppts?.filter({$0.isDone == false}) {
                    ScrollView{
                        ForEach(appts) { appt in
                           AppointmentViewRow(appt: appt)
                        }
                    }
                    VStack{
                        VStack(alignment: .leading){
                            Text("Grooming duration approximately 3 hrs. ")
                            Text("Appoinment Cancellation with no fee 24 hrs. prior grooming day.")
                                .multilineTextAlignment(.leading)
                        }.font(.footnote)
                            .bold()
                            .padding(.vertical)
                    }
                    
            
                }
            }else{
                Text("No Upcomimg Appointment yet.")
            }
            
            
        }
        .onAppear {
            Task{
                try await viewModel.fetchAppt()
            }
        }
        /*
        VStack{
        if !viewModel.appts.isEmpty {
            
            if let appts = viewModel.sortedAppts.filter({ $0.isDone == false}){
                Text("Upcoming Appointments")
                    .font(.title2)
                    .bold()
                ScrollView{
                    ForEach(appts) { appt in
                       AppointmentViewRow(appt: appt)
                    }
                }
                VStack{
                    VStack(alignment: .leading){
                        Text("Grooming duration approximately 3 hrs. ")
                        Text("Appoinment Cancellation with no fee 24 hrs. prior grooming day:)")
                            .multilineTextAlignment(.leading)
                    }.font(.footnote)
                        .bold()
                        .padding(.vertical)
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
         */
    }
}
    

struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView()
    }
}
