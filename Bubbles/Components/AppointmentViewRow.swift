//
//  AppointmentViewRow.swift
//  Bubbles
//
//  Created by Jessie P on 7/13/23.
//

import SwiftUI

struct AppointmentViewRow: View {
    @ObservedObject var viewModel = ApptViewModel()
    var appt: Appointment
    @State private var showAlert = false
    var body: some View {
        
        VStack(alignment: .leading){
            
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
            
            HStack( spacing: 20 ){
                Button {
                    showAlert = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 140, height: 39)
                            .foregroundColor(Color(.systemRed))
                        Text("Cancel Appointment")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .bold()
                    }
                }.alert(isPresented: $showAlert) {
                    Alert(title: Text("Cancel this appointment?"), primaryButton: .destructive(Text("Cancel")) {
                        //delete appt form collection
                        Task{
                            try await viewModel.deleteAppt(appt: appt)
                            //update groomerSchedule timeSlotBooked : true -> false
                            try await viewModel.updateFreeSlot(appt: appt)
                            //fetch all appt to display
                            try await viewModel.fetchAppt()
                        }
                                         
                    }, secondaryButton: .cancel())
                }
                
                Button {
                    //
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 120, height: 39)
                            .foregroundColor(Color(.systemCyan))
                        Text("Call store")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            
        }
        .frame(width: 380, height: 250, alignment: .center)
        .background(Color(.systemCyan).opacity(0.3).cornerRadius(15))
        
    }
}

struct AppointmentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentViewRow(appt: Appointment(id: "1", store: "PuppyPaws", service: "FullGrooming", addOnService: "Nailcut", groomer: "Lisa", dueDate: Date(), time: "2pm", timeDate: Date(), note: "Hachi is very sensitive", ownerId: "123", petName: "Hachi", groomerId: "123", dateCreated: Date(), dayOfWeek: DayOfWeek(rawValue: "Wed") ?? .monday))
    }
}
