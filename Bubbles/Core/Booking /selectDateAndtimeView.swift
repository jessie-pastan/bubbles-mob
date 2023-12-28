//
//  CreateApptView2.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct selectDateAndtimeView: View {
    @State var date = Date()
    @State var selectedTime = 1

    var body: some View {
        VStack{
            // select date
            Text("Select Grooming Date")
                .font(.title2)
                .bold()
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
            
            // select time
            Text("Select Grooming time")
                .font(.title2)
                .bold()
           
            Picker("", selection: $selectedTime) {
                Text("10.00 am").tag(1)
                Text("11.00 am").tag(2)
                Text("12.00 am").tag(3)
                Text("1.00 pm").tag(4)
                Text("2.00 pm").tag(5)
                
            }
            .pickerStyle(.segmented)
            
            Button {
                //save appt
            } label: {
                Text("Next")
            }

        }
    }
}

struct CreateApptView2_Previews: PreviewProvider {
    static var previews: some View {
        selectDateAndtimeView()
    }
}
