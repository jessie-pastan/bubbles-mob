//
//  RegisterView.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel =  RegisterViewModel()
    
    var body: some View {
        NavigationStack{
            Spacer()
            Text("Register")
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
            Spacer()

            Button {
                Task{
                    try await viewModel.registerUser()
                }
            } label: {
                ButtonView(title: "Register Account")
            }
            .padding(.bottom, 20)


        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            
    }
}
