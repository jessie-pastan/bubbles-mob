//
//  SelectTimeView.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import SwiftUI

struct SelectTimeView: View {
    
    @EnvironmentObject var viewModel: BookingViewModel
    
    var body: some View {
        NavigationStack{
            // select time
            Spacer()
            Text("Select Grooming session")
                .font(.title2)
                .bold()
            
            Picker("", selection: $viewModel.selectedTime) {
                Text("10.00 am").tag("10.00 am")
                Text("11.00 am").tag("11.00 am")
                Text("12.00 am").tag("12.00 am")
                Text("1.00 pm").tag("1.00 pm")
                Text("2.00 pm").tag("2.00 pm")
                
            }
            .padding()
            .pickerStyle(.segmented)
            
            Spacer()
            NavigationLink {
                NoteView()
            } label: {
                ButtonView(title: "Next")
            }
            .padding(.bottom, 20)
        }
    }
}

struct SelectTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTimeView()
            .environmentObject(BookingViewModel())
    }
}
