//
//  GroomerNoteView.swift
//  Bubbles
//
//  Created by Jessie P on 7/29/23.
//

import SwiftUI

struct GroomerNoteView: View {
   @ObservedObject var viewModel  = GroomerNoteViewModel()
    
    var appt: Appointment
    
    var body: some View {
        VStack{
            Text("Groomer Note")
            .padding(.bottom, 20)
            .bold()
            
            if let note = appt.groomerNote {
                Text(note.text)
                Text(note.groomer)
                Text(note.date.formatted(date: .abbreviated, time: .omitted))
                
                
                if viewModel.user?.isGroomer ?? true {
                    Button {
                        
                        Task{
                            //let groomer edit note
                        }
                        
                        
                    } label: {
                        Text("Edit")
                            .padding()
                            .frame(width: 100, height: 39)
                            .background(Color(.systemCyan).cornerRadius(15))
                            .foregroundColor(.white)
                    }
                }
                
                
            }
            
            if appt.groomerNote ==  nil && viewModel.user?.isGroomer ?? true {
                
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
            Task{
                 try await viewModel.fetchUpdateGroomerNote(appt:appt)
            }
        }
        
    }
}

struct GroomerNoteView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerNoteView(appt: Appointment.MOCK_APPOINTMENT)
    }
}
