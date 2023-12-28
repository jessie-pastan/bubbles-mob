//
//  RabiesExpirationView .swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct RabiesExpirationView: View {
    
    @EnvironmentObject  var viewModel: AddPetViewModel
   
    var body: some View {
        VStack{
            Spacer()
            Text("Rabies certificate expiration date ")
                .font(.title2)
                .bold()
            VStack{
                DatePicker("", selection: $viewModel.expirationDate,displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink {
                UploadCertificateView()
            } label: {
                ButtonView(title: "Next")
            }
            
            .padding(.bottom, 20)
        }
    }
}

struct RabiesExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        RabiesExpirationView()
            .environmentObject(AddPetViewModel())
        
    }
}
