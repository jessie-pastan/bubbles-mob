//
//  SelectTimeView.swift
//  Bubbles
//
//  Created by Jessie P on 7/10/23.
//

import SwiftUI

struct SelectTimeView: View {
    @State var selectedTime = 1
    
    var body: some View {
        NavigationStack{
            // select time
            Spacer()
            Text("Select Grooming session")
                .font(.title2)
                .bold()
            
            Picker("", selection: $selectedTime) {
                Text("10.00 am").tag(1)
                Text("11.00 am").tag(2)
                Text("12.00 am").tag(3)
                Text("1.00 pm").tag(4)
                Text("2.00 pm").tag(5)
                
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
    }
}
