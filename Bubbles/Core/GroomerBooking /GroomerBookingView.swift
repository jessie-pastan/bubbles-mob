//
//  GroomerBoookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/27/23.
//

import SwiftUI

struct GroomerBookingView: View {
    @StateObject var viewModel = GroomerBookingViewModel()
    var body: some View {
        VStack{
            DatePicker("Today", selection:$viewModel.date , displayedComponents: .date)
                .datePickerStyle(.graphical)
                .font(.largeTitle)
                .onChange(of: viewModel.date, perform: { newValue in
                    Task{
                        try await viewModel.fetchTodayBookings(date: viewModel.date)
                    }
                })

            ScrollView{
                VStack(alignment: .leading){
                    Text("Tasks")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,35)
                    if !viewModel.appts.isEmpty{
                        ForEach(viewModel.sortedAppts) { appt in
                            BookingRowView(appt: appt)
                            
                        }
                        .padding(.horizontal)
                    }else{
                        VStack{
                            Text("No booking yet.")
                        }
                        .font(.title)
                        .bold()
                        .offset(x: 40, y: 50)
                        
                    }
                }
            }
        }
        
    }
}

struct GroomerBoookingView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerBookingView()
    }
}
