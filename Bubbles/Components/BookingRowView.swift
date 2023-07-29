//
//  HeaderView.swift
//  Bubbles
//
//  Created by Jessie P on 7/16/23.
//

import SwiftUI

struct BookingRowView: View {
    @StateObject var viewModel = GroomerBookingViewModel()
    var appt : Appointment
    @State private var isTapforPickUp = false
    @State private var isTapRemind = false
    
    var body: some View {
        
        
        VStack{
            VStack(alignment: .leading){
                
                HStack{
                    Text("\(appt.time) :")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(appt.petName)
                        .font(.title)
                    Spacer()
                
                    Button {
                        //create grooming note for this booking 
                    } label: {
                        HStack{
                            //Text("GroomerNote")
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .accentColor(.black)

                }
                HStack{
                    Text(appt.service)
                    Text("Add On : \(appt.addOnService)")
                    
                }
                if appt.note == "" {
                    Text("Note: \(appt.note ?? "None")")
                }else{
                    Text("Note: \(appt.note ?? "None")")
                    
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 60){
                //send reminder button
                Button {
                    if !isTapRemind {
                        Task{
                           //send reminder
                        }
                        isTapRemind = true
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 39)
                            .foregroundColor(isTapRemind ? Color(.gray) : Color(.systemMint))
                        Text("Send Reminder")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .disabled(isTapRemind)
                
                // pick up button
                Button {
                    if !isTapforPickUp {
                        Task{
                            try await viewModel.updateDone(item: appt)
                        }
                        isTapforPickUp = true
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 39)
                            .foregroundColor(isTapforPickUp || appt.isDone ? Color(.gray)  : Color(.systemCyan))
                            
                        Text("Ready for Pickup")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
                .disabled(isTapforPickUp)
            }
            
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal,20 )
        .background(Color(.systemCyan).opacity(0.3).cornerRadius(10))
    }
}

struct BookingRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookingRowView(appt: Appointment.MOCK_APPOINTMENT)
    }
}
