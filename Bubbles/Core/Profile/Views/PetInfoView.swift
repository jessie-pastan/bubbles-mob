//
//  PetInfoView.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import SwiftUI

struct PetInfoView: View {
    @EnvironmentObject  var viewModel: AddPetViewModel
    
    var body: some View {
        NavigationStack{
            Spacer()
            Text("Pet Infomation")
                .font(.title2)
                .bold()
            Image(systemName: "photo.circle")
                .resizable()
                .frame(width: 100, height: 100)
            Button {
                //uploadImage
            } label: {
                Text("Upload pet image")
            }
            
            VStack(alignment: .leading){
                TextField("Name", text: $viewModel.petName)
                TextField("Breed", text: $viewModel.petBreed)
                TextField("Age", text: $viewModel.petAge)
                TextField("Weight in lbs", text: $viewModel.petWeight)
            }
            .autocorrectionDisabled()
            .textFieldStyle(.roundedBorder)
            .padding()
            
            
            HStack{
                Text("My pet is")
                Button {
                    viewModel.isDog = true
                } label: {
                    Text("")
                        .frame(width: 8, height: 8)
                        .background(viewModel.isDog ? .black : .white)
                        .cornerRadius(100)
                        .foregroundColor(.black)
                        .padding()
                    //stroke modified roundRectangled
                        .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.black, lineWidth: 6)
                        .scaleEffect(0.6)
                        )
                    Text("Doggy")
                }
                    
                Button {
                    viewModel.isDog = false
                } label: {
                    Text("")
                        .frame(width: 8, height: 8)
                        .background(viewModel.isDog ? .white : .black)
                        .cornerRadius(100)
                        .foregroundColor(.black)
                        .padding()
                    //stroke modified roundRectangled
                        .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.black, lineWidth: 6)
                        .scaleEffect(0.6)
                        )
                        Text("Kitty")
                }
            }
            .accentColor(.black)
            
            
            Spacer()
            
            NavigationLink {
                PetMedicationInfoView()
            } label: {
                ButtonView(title: "Next")
            }
            .isDetailLink(false)
            .padding(.bottom, 20)
        }
    }
}

struct PetInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PetInfoView()
            .environmentObject(AddPetViewModel())
            
    }
}
