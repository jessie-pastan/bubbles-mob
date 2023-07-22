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
                .font(.title3)
                .bold()
                .lineLimit(1)
            Text("For: \(appt.petName)")
            Text("Service: \(appt.service)")
            //if any add on service
            Text("Add on: \(appt.addOnService )")
            Text("Groomer: \(appt.groomer)")
            Text("DueDate: \(appt.dueDate.formatted(date: .abbreviated, time: .omitted))")
            Text("Appiontment Time: \(appt.time)")
            Text("Special Request: \(appt.note ?? "None")")
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
        AppointmentViewRow(appt: Appointment(id: "1", store: "PuppyPaws", service: "FullGrooming", addOnService: "Nailcut", groomer: "Lisa", dueDate: Date(), time: "2pm", note: "Hachi is very sensitive", ownerId: "123", petName: "Hachi", groomerId: "123", dateCreated: Date()))
    }
}
