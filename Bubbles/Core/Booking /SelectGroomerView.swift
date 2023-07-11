//
//  SelectGroomerView.swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct SelectGroomerView: View {
    
    @EnvironmentObject var viewModel : BookingViewModel

    var body: some View {
        NavigationStack{
            Spacer()
            Text("Select add on Service")
                .font(.title2)
                .bold()
            Picker("", selection: $viewModel.selectedAddOnService) {
                Text("Teeth Brush").tag("Teeth Brush")
                Text("Detangle").tag("Detangle")
                Text("None").tag("None")
                
            }
            .padding()
            .pickerStyle(.segmented)
            Spacer()
            //select a specific groomer or any availble groomer
            Text("Select Groomer")
                .font(.title2)
                .bold()
            Picker("", selection: $viewModel.selectedGroomer) {
                Text("Lisa").tag("Lisa")
                Text("Jenny").tag("Jenny")
                Text("Rose").tag("Rose")
                Text("Jisoo").tag("Jisoo")
                Text("Any Avialable").tag("Any Avialable")
                
            }
            .padding()
            .pickerStyle(.menu)
            Spacer()
            NavigationLink(destination: {
                SelectDateView()
            }, label: {
                ButtonView(title: "Next")
            })
            .padding(.bottom, 80)
        }
    }
}

struct SelectGroomerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGroomerView()
            .environmentObject(BookingViewModel())
    }
}
