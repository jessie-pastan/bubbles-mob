//
//  GroomerRegisterView.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import SwiftUI

struct GroomerRegisterView: View {
    
    @StateObject var viewModel = GroomerRegisterViewModel()
    
    var body: some View {
        NavigationStack{
            Spacer()
            Text("Groomer Register")
                .font(.title2)
                .bold()
            
            VStack{
                TextField("User name", text: $viewModel.userName)
                TextField("Email", text: $viewModel.email)
                SecureField("Password at least 6 Characters", text: $viewModel.password)
                TextField("Phone Number xxx-xxx-xxxx", text: $viewModel.phoneNumber)
                
            }
            .autocapitalization(.none)
            .textFieldStyle(.roundedBorder)
            .padding()
            
            HStack{
                Text("Grooming Store: ")
                Spacer()
                if let stores = viewModel.groomingStoresList {
                    Picker("", selection: $viewModel.groomingStoreId) {
                        ForEach(stores) { store in
                            Text(store.name).tag(store.id)
                        }
                    }
                    
                } else {
                    Text("Stores is empty")
                }
            }.padding(.horizontal)
            
            
            
           
            
            Spacer()

            Button {
                Task{
                    try await viewModel.registerGroomer()
                }
            } label: {
                ButtonView(title: "Register Account")
            }
            .padding(.bottom, 20)


        }
    }
}


struct GroomerRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerRegisterView()
    }
}
