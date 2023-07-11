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
                Text("Booking at: PuppyPaws")
                Text("Service: BasicBath")
                //if any add on service
                Text("Add on: Teeth Brushing")
                Text("Groomer: Lisa")
                Text("Date: 7/10/23")
                Text("Appiontment Time: 2 pm")
                Text("Special Request: ......")
                Text("Grooming duration approximately 3 hrs. ")
                Text("Edit or Cancel appointment is allowed 24 hrs. prior grooming time:)")
            }
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
