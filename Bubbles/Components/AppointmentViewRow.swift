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
        
        VStack(alignment: .leading, spacing: 30){
            Text("Booking at: \(appt.store)")
            Text("For: \(appt.petName)")
            Text("Service: \(appt.service)")
            //if any add on service
            
            Text("Add on: \(appt.addOnService ?? "None")")
        
            Text("Groomer: \(appt.groomer)")
            Text("DueDate: \(Date(timeIntervalSince1970: appt.dueDate).formatted(date: .abbreviated, time: .omitted))")
            Text("Appiontment Time: \(appt.time)")
            Text("Special Request: \(appt.note ?? "")")
            VStack(alignment: .leading){
                Text("Grooming duration approximately 3 hrs. ")
                Text("Edit or Cancel appointment is allowed 24 hrs. prior grooming day:)")
            }.font(.footnote)
                .bold()
            
        }
    }
}

struct AppointmentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentViewRow(appt: Appointment(id: "1", store: "PuppyPaws", service: "FullGrooming", addOnService: "Nailcut", groomer: "Lisa", dueDate: Date().timeIntervalSince1970, time: "2pm", note: "Hachi is very sensitive", ownerId: "123", petName: "Hachi", dateCreated: Date().timeIntervalSince1970))
    }
}
