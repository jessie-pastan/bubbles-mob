//
//  PetMedicationInfoView.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import SwiftUI

struct PetMedicationInfoView: View {
    @EnvironmentObject  var viewModel: AddPetViewModel
    
    var body: some View {
        NavigationStack{
            
            Spacer()
            Text("Your pet is important to us! ")
                .font(.title2) 
                .bold()
            VStack(alignment: .leading){
                
                Text("Is your pet on any medication?")
                HStack{
                    Button {
                        viewModel.isMed = true
                    } label: {
                        Text("")
                            .frame(width: 8, height: 8)
                            .background(viewModel.isMed ? .black : .white)
                            .cornerRadius(100)
                            .foregroundColor(.black)
                            .padding()
                        //stroke modified roundRectangled
                            .overlay(RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.black, lineWidth: 6)
                            .scaleEffect(0.6)
                            )
                        Text("Yes")
                    }
                        
                    Button {
                        viewModel.isMed = false
                    } label: {
                        Text("")
                            .frame(width: 8, height: 8)
                            .background(viewModel.isMed ? .white : .black)
                            .cornerRadius(100)
                            .foregroundColor(.black)
                            .padding()
                        //stroke modified roundRectangled
                            .overlay(RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.black, lineWidth: 6)
                            .scaleEffect(0.6)
                            )
                            Text("No")
                    }
                }
                .accentColor(.black)
                TextField("Pet Medication(s)", text: $viewModel.petMedication)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            Spacer()
            
            NavigationLink {
                RabiesExpirationView()
            } label: {
                ButtonView(title: "Next")
            }
            
            .padding(.bottom, 20)
        }
    }
}

struct PetMedicationInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PetMedicationInfoView()
            .environmentObject(AddPetViewModel())
        
    }
}
