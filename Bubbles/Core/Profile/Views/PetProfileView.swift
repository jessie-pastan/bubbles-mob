//
//  PetProfileView.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import SwiftUI

struct PetProfileView: View {
    var pet: Pet
    var user: User
    @Binding var selectedIndex: Int
    
    var body: some View {
        VStack{
            Spacer()
            Text("Pet Profile")
                .font(.title2)
                .bold()
            Image("user4")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .cornerRadius(100)
            VStack(alignment: .leading){
                Text(pet.name)
                Text(pet.breed)
                Text("\(pet.age) year old")
            }
            
            Spacer()
            Button {
                //back to homepage
               selectedIndex = 0
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 350, height: 39)
                        .foregroundColor(Color(.systemMint))
                    Text("Book grooming session")
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding(.bottom, 5)
            
            
            
            NavigationLink {
                //show edit view
                EditPetProfileView()
            } label: {
                ButtonView(title: "Edit Pet Profile")
            }
            .padding(.bottom, 20)
           
        }
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView(pet: Pet.MOCK_PETS[0], user: User.MOCK_USERS[0], selectedIndex: .constant(0))
    }
}
