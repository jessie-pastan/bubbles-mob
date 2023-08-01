//
//  GroomerNoteView.swift
//  Bubbles
//
//  Created by Jessie P on 7/29/23.
//

import SwiftUI

struct GroomerNoteForClientView: View {
   
    @EnvironmentObject var viewModel : ApptViewModel
    
    var body: some View {
        VStack{
            Text("Groomer Note")
            .padding(.bottom, 20)
            .bold()
            
            if let note = viewModel.selectedAppt?.groomerNote {
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
                
            }else{
                
                VStack{
                    Text("No note yet.")
                    
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding()
                .background(Color(.systemMint).opacity(0.3).cornerRadius(15))
                .padding()
                
                
            }
       
        }
         
        
    }
}

struct GroomerNoteForClientView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerNoteForClientView()
    }
}
