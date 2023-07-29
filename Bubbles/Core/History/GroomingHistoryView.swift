//
//  GroomingHistoryView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct GroomingHistoryView: View {
    
    @StateObject var viewModel = ApptViewModel()

    var body: some View {
        VStack{
            if !viewModel.appts.isEmpty {
                if let appts = viewModel.sortedAppts.filter({ $0.isDone == true}){
                    Text("Completed Appointments")
                        .font(.title2)
                        .bold()
                    ScrollView{
                        ForEach(appts) { appt in
                            VStack{
                                
                                Text("Booking at: \(appt.store)")
                                    .font(.title3)
                                    .bold()
                                    .lineLimit(1)
                                Text("For: \(appt.petName)")
                                Text("Date: \(appt.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                Text("Appiontment Time: \(appt.time)")
                                Text("Service: \(appt.service)")
                                //if any add on service
                                Text("Add on: \(appt.addOnService )")
                                Text("Groomer: \(appt.groomer)")
                                
                                Button {
                                    //
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 150, height: 39)
                                            .foregroundColor(Color(.systemCyan))
                                        Text("View groomer note")
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                            .bold()
                                    }
                                }
                            }
                            .frame(width: 300, height: 300, alignment: .center)
                            .background(Color(.systemCyan).opacity(0.3).cornerRadius(15))
                            
                        }
                    }
                }
            }else{
                Text("No history.")
            }
        }.onAppear {
            Task{
                try await viewModel.fetchAppt()
            }
            
            
        }
    }
    
}

struct GroomingHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        GroomingHistoryView()
    }
}
