//
//  PetDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 8/3/23.
//

import SwiftUI

struct PetDetailView: View {
    @ObservedObject var viewModel = PetDetailViewModel()
    @State private var text = ""
    @State private var servicePrice = ""
    @State private var addOnPrice = ""
    @State private var totalPrice = ""
    
    var appt: Appointment
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    
                    Text("\(viewModel.pet?.name ?? "") ").font(.title2).bold()
                    Text("Breed: \(viewModel.pet?.breed ?? "")")
                    Text("Weight: \(viewModel.pet?.weight ?? "")lbs.")
                }
                
                HStack{
                    Text("Age: \(viewModel.pet?.age ?? "") yr.")
                    if viewModel.pet?.petMedication == "" {
                        Text("Pet medication: None")
                    }else{
                        Text("Pet medication: \(viewModel.pet?.petMedication ?? "" )")
                    }
                }
                
                Text("Contact: \(viewModel.client?.phoneNumber ?? "" ) \(viewModel.client?.userName ?? "" )")
            }
            
            
            
            VStack{
                Divider()
                Text("Grooming History")
                /*
                 .padding()
                 .bold()
                 .font(.title3)
                 .background(Color(.systemMint).cornerRadius(15))
                 .frame(width: 200, height: 39)
                 */
                
                ScrollView {
                    ForEach(viewModel.petHistories) { history in
                        PetHistoryRowView(petHistory: history)
                    }
                    
                }
                VStack{
                    //Divider()
                    VStack(alignment: .leading) {
                        Text("Appointment date: \(appt.dueDate.formatted(date: .abbreviated, time: .omitted))")
                        HStack{
                            Text("Service : \(appt.service) ")
                            TextField("$Service price", text: $viewModel.servicePrice)
                        }
                        HStack{
                            Text("Add on: \(appt.addOnService) ")
                            TextField("$Add on price", text: $viewModel.addOnPrice)
                        }
                        TextField("Add grooming detail", text: $viewModel.text)
                        Text("Create date: \(Date().formatted(date: .abbreviated, time: .omitted))")
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                    
                    
                    
                    Button {
                        
                        Task{
                            //add grooming history
                            try await viewModel.uploadPetHistory(appt:appt)
                            // update groomer compensate
                            try await viewModel.updateGroomerIncomeData(servicePrice: viewModel.servicePrice, addOnPrice: viewModel.addOnPrice, appt: appt)
                            //try await viewModel.updateGroomerCompensate(servicePrice: viewModel.servicePrice, addOnPrice: viewModel.addOnPrice, appt: appt)
                            try await viewModel.fetchPetHistory(pet: viewModel.pet ?? Pet.MOCK_PETS[0])
                            
                        }
                    } label: {
                        Text("Add grooming history")
                            .bold()
                            .padding()
                            .frame(width: 230, height: 39)
                            .background(Color(.systemCyan).cornerRadius(15))
                            .foregroundColor(.white)
                            
                        
                    }.padding()
                    
                }
                .padding()
                .background(Color(.systemMint).opacity(0.3).cornerRadius(15).padding())
                
                
            }
        }.onAppear {
            Task{
                try await viewModel.fetchClientfromAppt(appt:  appt)
                try await viewModel.fetchPetOfAppt(appt: appt)
                try await viewModel.fetchPetHistory(pet: viewModel.pet ?? Pet.MOCK_PETS[0])
            }
        }
    }
    
}
struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailView(appt: Appointment.MOCK_APPOINTMENT)
    }
}
