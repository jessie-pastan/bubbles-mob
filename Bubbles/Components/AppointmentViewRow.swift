//
//  AppointmentViewRow.swift
//  Bubbles
//
//  Created by Jessie P on 7/13/23.
//

import SwiftUI

struct AppointmentViewRow: View {
    var appt: Appointment
    var body: some View {
        
        VStack{
            VStack{
                VStack(alignment: .leading){
                    Text("Booking at: \(appt.store)")
                        .font(.title3)
                        .bold()
                        .lineLimit(1)
                    Text("For: \(appt.petName)")
                    Text("Service: \(appt.service)")
                    //if any add on service
                    Text("Add on: \(appt.addOnService )")
                    Text("Groomer: \(appt.groomer)")
                    Text("Date: \(appt.dueDate.formatted(date: .abbreviated, time: .omitted))")
                    Text("Appiontment Time: \(appt.time)")
                    //Text("Note: \(appt.note ?? "None")")
                    VStack(alignment: .leading){
                        Text("Grooming duration approximately 3 hrs. ")
                        Text("Appoinment Cancellation is allowed 24 hrs. prior grooming day:)")
                    }.font(.footnote)
                        .bold()
                        .padding(.vertical)
                }.padding(.horizontal).padding(.vertical)
                
                
                HStack(spacing: 10){
                    //cancel appt button
                    Button {
                        //
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 39)
                                .foregroundColor(Color(.systemRed))
                            Text("Cancel Appointment")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                    
                    // call store button
                    Button {
                        //
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 39)
                                .foregroundColor(Color(.systemCyan))
                            Text("Call Store")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }.padding(.bottom,20).padding(.horizontal)
            }
        }
        
        .frame(width:410, height: 400)
        .background(Color(.systemCyan).opacity(0.3).cornerRadius(15))
        
    }
}

struct AppointmentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentViewRow(appt: Appointment(id: "1", store: "PuppyPaws", service: "FullGrooming", addOnService: "Nailcut", groomer: "Lisa", dueDate: Date(), time: "2pm", timeDate: Date(), note: "Hachi is very sensitive", ownerId: "123", petName: "Hachi", groomerId: "123", dateCreated: Date()))
    }
}
