//
//  GroomerBoookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/27/23.
//

import SwiftUI

struct GroomerBookingView: View {
    @StateObject var viewModel = GroomerBookingViewModel()
    @State private var isTakeDayOff = false
    
    var body: some View {
        NavigationStack{
            VStack{
                DatePicker("Today", selection:$viewModel.date , displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .font(.largeTitle)
                    .onChange(of: viewModel.date, perform: { newValue in
                        Task{
                            try await viewModel.fetchTodayBookings(date: viewModel.date)
                            let _ = try await viewModel.fetchSelectedSchedule(date: viewModel.date)
                            print(viewModel.date)
                        }
                    })
                
                ScrollView{
                    VStack(alignment: .leading){
                        Text("Bookings")
                            .font(.title)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                        
                        if !viewModel.appts.isEmpty{
                            ForEach(viewModel.sortedAppts) { appt in
                                BookingRowView(appt: appt)
                            }
                            .padding(.horizontal)
                            
                            
                        }else{
                            
                            VStack{
                                Text("No booking yet.")
                                
                            }
                            .padding()
                            .font(.title)
                            .bold()
                            
                            
                            
                            Toggle(isOn: $viewModel.isTakeDayOff) {
                                VStack(alignment: .leading){
                                    Text("Take a day off? ")
                                    Text("When turn this on will block all day slots")
                                        .foregroundColor(.red)
                                        .font(.subheadline)
                                }
                            }
                            .padding()
                            .font(.subheadline)
                            .bold()
                            .onChange(of: viewModel.isTakeDayOff) { newValue in
                                
                                if newValue{
                                    Task{
                                        try await viewModel.updateDayoffToggleTrue(schedule: viewModel.schedule ?? Schedule.MOCK_selectedDateAndTime)
                                    }
                                    
                                }else{
                                    Task{
                                        try await viewModel.updateDayoffToggleFalse(schedule: viewModel.schedule ?? Schedule.MOCK_selectedDateAndTime)
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }.onAppear {
                Task{
                    try await viewModel.fetchAllSched()
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
