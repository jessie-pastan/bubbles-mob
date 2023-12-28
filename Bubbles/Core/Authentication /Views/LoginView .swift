//
//  LoginView .swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack{
            Spacer()
            Image(systemName: "pawprint")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
            Text("Welcome to Bubbles!")
                .font(.title2)
                .bold()
            VStack{
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                SecureField("Password", text: $viewModel.password)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            
            Button {
                //login
                Task{
                    try await viewModel.loginUser()
                    
                }
            } label: {
                ButtonView(title: "Log In")
            }
            
            
            Spacer()
            NavigationLink {
                ChooseRegisterView()
            } label: {
                Text("New around here? Create Account.")
            }
        }
    }
}

struct LoginView__Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}
