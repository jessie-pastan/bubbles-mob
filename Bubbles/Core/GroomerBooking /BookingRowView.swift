//
//  HeaderView.swift
//  Bubbles
//
//  Created by Jessie P on 7/16/23.
//

import SwiftUI

struct BookingRowView: View {
    @ObservedObject var viewModel = GroomerBookingViewModel()
    @StateObject var sheetController = SheetController()
   
   
    var appt : Appointment
   
    
    @State private var isTapforPickUp = false
    @State private var isTapRemind = false
    @State private var isNoteShow = false
    
    
    
    var body: some View {
        
        
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Text("\(appt.time) :")
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(appt.petName)
                        .font(.title)
                    //testing delete when done 
                    //Text(appt.groomerNote?.text ?? "no note")
                    
                    Spacer()
                
                    Button {
                       
                        sheetController.showNoteSheet()
                        
                    } label: {
                        HStack{
                            //Text("GroomerNote")
                            Image(systemName: "note.text")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .accentColor(.black)
                    .sheet(isPresented: $sheetController.isShowingNoteSheet) {
                        GroomerNoteView(sheetController: sheetController, appt: appt  )
                    }

                }
                
                HStack{
                    
                        Text(appt.service)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Add On : \(appt.addOnService)")
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if appt.note == "" {
                    
                }else{
                    Text("Note: \(appt.note ?? "None")")
                        .padding(.top)
                    
                }
            }
            .padding(30)
            .padding(.top,-20)
            .font(.subheadline)
            //.frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 10){
                //send reminder button
                Button {
                    if !isTapRemind {
                        Task{
                           //send reminder
                            try await viewModel.updateSentReminder(item: appt)
                            NotificationViewModel().uploadNotification(toUid: appt.ownerId, type: .reminder, appt: appt)
                        }
                        isTapRemind = true
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 39)
                            .foregroundColor(isTapRemind || appt.reminderSent ? Color(.gray) : Color(.systemMint))
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
                            NotificationViewModel().uploadNotification(toUid: appt.ownerId, type: .completeGrooming, appt: appt)
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
        
        .padding(.vertical, 20)
        .padding(.horizontal,-20 )
        .background(Color(.systemCyan).opacity(0.3).cornerRadius(10))
        
    }
}

struct BookingRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookingRowView(appt: Appointment.MOCK_APPOINTMENT)
    }
}
