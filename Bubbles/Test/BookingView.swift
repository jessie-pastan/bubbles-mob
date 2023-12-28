//
//  BookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//
/*
import SwiftUI

struct BookingView: View {
    var groomer: Groomer
    @State var isShow = false
    var body: some View {
        
        VStack {
            Text("Booking grooming session")
                .font(.title2)
            VStack(alignment: .leading){
                Text("select your pet")
                Text("select service")
                Text("select date")
                Text("selcet time")
                Text("selected groomer:  \(groomer.name)")
            }
            .padding()
            
            Button {
                //save appt and go back to
                //show success booking
                isShow.toggle()
                
            } label: {
                Text("Confirm appt.")
            }
            .sheet(isPresented: $isShow) {
                SuccessView()
            }
            
        }
        
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView(groomer: Groomer.groomers[0])
    }
}
*/
