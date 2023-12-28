//
//  GroomerNoteView.swift
//  Bubbles
//
//  Created by Jessie P on 7/31/23.
//

import SwiftUI

struct GroomerNoteView: View {
    @ObservedObject var viewModel = GroomerNoteViewModel()
    @ObservedObject var sheetController: SheetController
    
    
    var appt: Appointment
    
    
    var body: some View {
        VStack{
            Text("Groomer Note")
                .padding(.bottom, 20)
                .bold()
            
            if let note = appt.groomerNote {
                VStack{
                    Text(note.text)
                    VStack {
                        Text(note.groomer)
                        Text(note.date.formatted(date: .abbreviated, time: .omitted))
                    }
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .padding()
                .background(Color(.systemMint).opacity(0.3).cornerRadius(15))
                .padding()
                
                
                    Button {
                        sheetController.showEditNoteSheet()
                       
                    } label: {
                        Text("Edit")
                            .padding()
                            .frame(width: 100, height: 39)
                            .background(Color(.systemCyan).cornerRadius(15))
                            .foregroundColor(.white)
                    }.sheet(isPresented: $sheetController.isShowingEditNoteSheet) {
                        EditGroomerNoteView( sheetController: sheetController, note: note, appt: appt)
                    }
                
            }else{
                TextField("Add Note", text: $viewModel.text)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                Button {
                    
                    Task{
                        try await viewModel.uploadGroomerNote(appt: appt)
                    }
                    
                } label: {
                    Text("Submit")
                        .padding()
                        .frame(width: 100, height: 39)
                        .background(Color(.systemCyan).cornerRadius(15))
                        .foregroundColor(.white)
                }
            }
        }.onAppear {
            //fetch updatedNote
            Task{
                try await viewModel.fetchUpdateGroomerNote(appt: appt)
            }
        }
    }
}


struct GroomerNoteView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerNoteView( sheetController: SheetController(), appt: Appointment.MOCK_APPOINTMENT)
    }
}
