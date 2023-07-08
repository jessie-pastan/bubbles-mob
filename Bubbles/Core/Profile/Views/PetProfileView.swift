//
//  PetProfileView.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import SwiftUI

struct PetProfileView: View {
    var pet: Pet
    var body: some View {
        VStack{
            Spacer()
            Text("Pet Profile")
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
                //show edit view
            } label: {
                ButtonView(title: "Edit Pet Profile")
            }
            .padding(.bottom, 20)
           
        }
    }
}

struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PetProfileView(pet: Pet.MOCK_PETS[0])
    }
}
