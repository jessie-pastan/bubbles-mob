//
//  UploadRabiesView.swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct UploadCertificateView: View {
    
    @EnvironmentObject  var viewModel: AddPetViewModel
    @State var showComplete = false
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Spacer()
                Text("Please provide a copy of rabies certificate")
                    .font(.title2)
                    .bold()
                    .padding()
                
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 150)
                
                
                Button {
                    //save Image
                    
                } label: {
                    Text("Upload Image")
                        .frame(width: 200, height: 39)
                        .background(Color(.systemMint))
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(15)
                }
                
                Spacer()
                Button {
                    //save user info
                    Task{
                        try await viewModel.updateData()
                        
                        showComplete.toggle()
                    }
                    
                } label: {
                    ButtonView(title: "Complete Profile")
                }
                
                .sheet(isPresented: $showComplete, content: {
                    CompletedPetProfileView()
                })
                 
                .padding(.bottom, 20)
            }
        }
    }
}

struct UploadRabiesView_Previews: PreviewProvider {
    static var previews: some View {
        UploadCertificateView()
            .environmentObject(AddPetViewModel())
        
    }
}
