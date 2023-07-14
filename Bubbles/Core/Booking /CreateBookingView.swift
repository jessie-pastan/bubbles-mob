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
    @FirestoreQuery var pets: [Pet]
    @State var showSuccess = false
    var store: Store
    
    init(store: Store){
        self._pets = FirestoreQuery(collectionPath: "users/\(Auth.auth().currentUser?.uid ?? "")/pets")
        self.store = store
    }
    
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
                        ForEach(pets) { pet in
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
                        Text("BasicBath").tag("BasicBath")
                        Text("SpaBath").tag("SpaBath")
                        Text("FullGrooming").tag("FullGrooming")
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
                    Picker("", selection: $viewModel.selectedGroomer) {
                        Text("Select Groomer").tag("Select Groomer")
                        Text("Lisa").tag("Lisa")
                        Text("Rose'").tag("Rose'")
                        Text("Jenny").tag("Jenny")
                        Text("Jisoo").tag("Jisoo")
                        
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
                
                HStack{
                    Text("Select Time")
                        .font(.callout)
                        .bold()
                    Spacer()
                    Picker("", selection: $viewModel.selectedTime) {
                        Text("Select Time").tag("Select Time")
                        Text("10.00 am").tag("10.00 am")
                        Text("11.00 am").tag("11.00 am")
                        Text("12.00 am").tag("12.00 am")
                        Text("1.00 pm").tag("1.00 pm")
                        Text("2.00 pm").tag("2.00 pm")
                    }
                    .pickerStyle(.automatic)
                }
                HStack{
                    Text("Leave a note")
                        .font(.callout)
                        .bold()
                    TextField("(If Any", text: $viewModel.note)
                        .textFieldStyle(.roundedBorder)
                }
               
                    
                
                
            }
            .padding()
          
            
            Spacer()
                Button {
                    // update petId
                    showSuccess.toggle()
                    viewModel.store = store.name
                    print(viewModel.store)
                    //unwind screen to HomePage
                    Task{
                        try await viewModel.updateData()
                    }
                    
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 200, height: 39)
                            .foregroundColor(Color(.systemMint))
                        Text("Create Booking")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .sheet(isPresented: $showSuccess) {
                    SuccessBookingView()
                }
            }
    }
}

struct CreateBookingView_Previews: PreviewProvider {
    static var previews: some View {
        CreateBookingView(store: Store.MOCK_STORES[0])
    }
}
