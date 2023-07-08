//
//  ChooseRegisterView.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import SwiftUI

struct ChooseRegisterView: View {
    var body: some View {
        NavigationStack{
            
            VStack(spacing: 50){
                Text("Resgister As")
                    .font(.title2)
                    .bold()
                NavigationLink {
                    //tap to  registerView
                    RegisterView()
                } label: {
                    
                    Text("I'm a Pawrent")
                        .font(.title2)
                        .bold()
                        .frame(width: 200, height: 50)                .background(Color(.systemCyan))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
                
                
                NavigationLink {
                    //tap to groomer registerView
                    GroomerRegisterView()
                    
                } label: {
                    
                    Text("I'm a Groomer")
                        .font(.title2)
                        .bold()
                        .frame(width: 200, height: 50)                .background(Color(.systemMint))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    
                }
            }
        }
    
    }
}

struct ChooseRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseRegisterView()
           
    }
}
