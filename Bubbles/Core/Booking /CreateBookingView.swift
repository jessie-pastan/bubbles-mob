//
//  CreateBookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct CreateBookingView: View {
    
    @EnvironmentObject var viewModel : BookingViewModel
   
    @State var showSuccess = false
    
    var store: Store
    
    var body: some View {
        VStack( spacing: 60){
            
            VStack(alignment: .leading){
                HStack{
                    Text("Book Grooming for")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Picker("", selection: $viewModel.petName) {
                        Text("Select Pet").tag("Select Pet")
                        ForEach(viewModel.pets) { pet in
                            Text("\(pet.name)").tag("\(pet.name)")
                        }
                    }.pickerStyle(.automatic)
                }
                HStack{
                    Text("Select Service")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Picker("Select Service", selection: $viewModel.selectedService) {
                        Text("Select Service").tag("Select Service")
                        ForEach(viewModel.storeServices) { service in
                            Text(service.item).tag(service.item)
                            
                        }
                    }
                    .pickerStyle(.automatic)
                }
                HStack{
                    Text("Select Add On Service")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Picker("Select Add On Service", selection: $viewModel.selectedAddOnService) {
                        Text("Select Add On").tag("Select Add On")
                        Text("Teeth Brush").tag("Teeth Brush")
                        Text("Nail Trimming").tag("Nail Trimming")
                        Text("Bluberry Facial").tag("Blueburry Facial")
                        Text("Detangle").tag("Detangle")
                        Text("None").tag("None")
                    }
                    .pickerStyle(.automatic)
                }
                
                HStack{
                    Text("Select Groomer")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Picker("", selection: $viewModel.selectedGroomerId) {
                        Text("Select Groomer").tag("Select Groomer")
                        ForEach(viewModel.groomers) { groomer in
                            Text(groomer.userName).tag(groomer.id)
                          
                        }
                    }
                    .pickerStyle(.automatic)
                }
            
                HStack{
                    Text("Select Date")
                        .font(.callout)
                        .bold()
                    DatePicker("", selection: $viewModel.selectedDate, displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
            
                //test fething schedule
                Button {
                    Task{
                        try await viewModel.fetchSelectedGroomer(groomerId: viewModel.selectedGroomerId)
                        try await viewModel.fetchGroomerSchedule(groomerId: viewModel.selectedGroomerId, selectDate: viewModel.selectedDate)
                        viewModel.showGroomerSlots(schedules: viewModel.groomerSchedule)
                    }
                } label: {
                    Text("Check Available Slot")
                }
                
                if !viewModel.groomerSlots.isEmpty{
                    HStack{
                        Text("Select Time")
                            .font(.callout)
                            .bold()
                        Spacer()
                        Picker("", selection: $viewModel.selectedTime) {
                            //Text("Select Time").tag("Select Time")
                            
                            ForEach(viewModel.groomerSlots) { timeslot in
                                Text(timeslot.timeString).tag(timeslot.timeString)
                                
                            }
                            
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                HStack{
                    Text("Leave a note")
                        .font(.callout)
                        .bold()
                    TextField("(If Any)", text: $viewModel.note)
                        .textFieldStyle(.roundedBorder)
                }
                
            }
            .padding()
            
            /*
            if !viewModel.groomerSchedule.isEmpty {
                ForEach(viewModel.groomerSchedule){ schedule in
                    Text(schedule.date.formatted(date: .abbreviated, time: .omitted))
                }
                Text(viewModel.selectedGroomerId)
                Text(viewModel.selectedGroomerName)
                Text(viewModel.selectedDate.formatted(date: .abbreviated, time: .omitted))
                
            }
            
        */
            Spacer()
                Button {
                    // update petId
                    showSuccess.toggle()
                    viewModel.store = store.name
                    print(viewModel.store)
                    print(viewModel.selectedGroomerId)
                    
                    //unwind screen to HomePage
                    Task{
                        
                        try await viewModel.updateData()
                    }
                    
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 350, height: 39)
                            .foregroundColor(Color(.systemCyan))
                        Text("Create Booking")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .sheet(isPresented: $showSuccess) {
                    SuccessBookingView()
                }
        }.onAppear {
            Task{
                try await viewModel.fetchStoreServices(storeId: store.id)
                try await viewModel.fetchGroomers(storeId: store.id)
            }
           
        }
    }
}

struct CreateBookingView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBookingView(store: Store.MOCK_STORES[0])
            .environmentObject(BookingViewModel())
    }
}
