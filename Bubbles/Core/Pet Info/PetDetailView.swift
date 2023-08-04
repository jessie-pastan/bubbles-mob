//
//  PetDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 8/3/23.
//

import SwiftUI

struct PetDetailView: View {
    @ObservedObject var viewModel = PetDetailViewModel()
    
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
            
            Divider()
            
            
            VStack{
                ScrollView{
                    
                    Text("Grooming History")
                        .bold()
                        .font(.title)
                    
                    Text("Date: ")
                    Text("Service: ")
                    Text("Add On: ")
                    Text("Detail: ")
                    Text("Groom by : ")
                    
                }
            }
            Button {
                //add grooming history
            } label: {
                Text("Add")
                    .padding()
                    .frame(width: 100, height: 39)
                    .background(Color(.systemCyan).cornerRadius(15))
                    .foregroundColor(.white)
                
            }
            
        }.onAppear {
            Task{
                try await viewModel.fetchClientfromAppt(appt:  appt)
                try await viewModel.fetchPetOfAppt(appt: appt)
            }
        }
    }
    
}
struct PetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailView(appt: Appointment.MOCK_APPOINTMENT)
    }
}
