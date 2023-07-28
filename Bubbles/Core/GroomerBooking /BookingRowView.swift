//
//  HeaderView.swift
//  Bubbles
//
//  Created by Jessie P on 7/16/23.
//

import SwiftUI

struct BookingRowView: View {
    var appt : Appointment
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
                        //create grooming note
                    } label: {
                        HStack{
                            Text("Note")
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
                Text("Memo:")
              
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 60){
                //send reminder button
                Button {
                    //
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width:150, height: 39)
                            .foregroundColor(Color(.systemMint))
                        Text("Send Reminder")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                
                // pick up button
                Button {
                    //
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 39)
                            .foregroundColor(Color(.systemCyan))
                        Text("Ready for Pickup")
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
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
