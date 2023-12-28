//
//  CompleteBookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct CompleteBookingView: View {
    @EnvironmentObject var viewModel: BookingViewModel

    var body: some View {
        
        NavigationStack{
            Spacer()
            Text("Booking Detail")
                .font(.title2)
                .bold()
            Spacer()
            Image(systemName: "pawprint")
                .resizable()
                .frame(width: 60, height: 60)
            Spacer()
            VStack(alignment: .leading, spacing: 30){
                Text("Booking at: \(viewModel.store)")
                Text("For:\(viewModel.petName)")
                Text("Service: \(viewModel.selectedService)")
                //if any add on service
                Text("Add on: \(viewModel.selectedAddOnService)")
                Text("Groomer: \(viewModel.selectedGroomerId)")
                Text("Date: \(Date(timeIntervalSince1970: viewModel.selectedDate.timeIntervalSince1970).formatted(date: .abbreviated, time: .omitted))")
                Text("Appiontment Time: \(viewModel.selectedTime)")
                Text("Special Request: \(viewModel.note)")
                VStack(alignment: .leading){
                Text("Grooming duration approximately 3 hrs. ")
                Text("Edit or Cancel appointment is allowed 24 hrs. prior grooming day:)")
                }.font(.footnote)
                    .bold()
                
            }
            .font(.footnote)
            .padding()
            
            
            Spacer()
            Button {
                //complete booking//save appt to firebase
                
                
            } label: {
                ButtonView(title: "Complete Booking")
            }
            .padding(.bottom,  80)
        }
        
    }
}

struct CompleteBookingView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteBookingView()
            .environmentObject(BookingViewModel())
    }
}
