//
//  EditGroomerNoteView.swift
//  Bubbles
//
//  Created by Jessie P on 7/31/23.
//

import SwiftUI

struct EditGroomerNoteView: View {
    @ObservedObject var viewModel = GroomerNoteViewModel()
    @ObservedObject var sheetController: SheetController
   
   
    
    
    var note: GroomerNote?
    var appt: Appointment?
    
    
    var body: some View {
        TextField(("\(note?.text ?? "" )"), text: $viewModel.text)
            .padding()
            .textFieldStyle(.roundedBorder)
        Button {
            
            Task{
                try await viewModel.uploadGroomerNote(appt: appt ?? Appointment.MOCK_APPOINTMENT)
                
            }
            
            sheetController.dismissAllSheets()
            
        } label: {
            Text("Submit")
                .padding()
                .frame(width: 100, height: 39)
                .background(Color(.systemCyan).cornerRadius(15))
                .foregroundColor(.white)
        }
    }
}

struct EditGroomerNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditGroomerNoteView(sheetController: SheetController())
    }
}
