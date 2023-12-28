//
//  CompletedPetProfileView.swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct CompletedPetProfileView: View {
    
    @EnvironmentObject var viewModel: AddPetViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Spacer()
            Text("Pet profile has completed")
                .font(.title2)
                .bold()
            Spacer()
            
            Button {
                //dismiss this screen
                dismiss()
            } label: {
                ButtonView(title: "Done")
            }
            .padding(.bottom,20)

            
        }
    }
}

struct CompletedPetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedPetProfileView()
            .environmentObject(AddPetViewModel())
    }
}
