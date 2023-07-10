//
//  CreateApptView2.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct SelectDateView: View {
    @State var date = Date()
    
    

    var body: some View {
        NavigationStack{
        
            VStack(spacing: 40){
                // select date
                Spacer()
                Text("Select Grooming Date")
                    .font(.title2)
                    .bold()
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                
              
                
                Spacer()
                NavigationLink {
                    SelectTimeView()
                } label: {
                    ButtonView(title: "Next")
                }
                .padding(.bottom, 60)
            }

        }
    }
}

struct SelectDate_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView()
    }
}
