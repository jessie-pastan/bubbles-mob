//
//  NoteView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct NoteView: View {
    
    @EnvironmentObject var viewModel: BookingViewModel
    
    var body: some View {
        
        NavigationStack{
        //user make a not to store/ groomer
            VStack {
                Spacer()
                Image(systemName: "pawprint")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                TextField("Leave a note (Any)", text: $viewModel.note)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Spacer()
                NavigationLink {
                    CompleteBookingView()
                } label: {
                    ButtonView(title: "Next")
                }
                .padding(.bottom, 20)
                
            }
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
            .environmentObject(BookingViewModel())
    }
}
