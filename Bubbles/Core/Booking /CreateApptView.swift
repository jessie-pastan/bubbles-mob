//
//  CreateApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct CreateApptView: View {
    @State var selectedService = 1
    @State var selectedAddOnService = 2
    @State var selectedGroomer = 1
    
    
    var body: some View {
        
        //select service
        NavigationStack{
            Spacer()
            VStack( spacing: 60){
                Text("Select Service")
                    .font(.title2)
                    .bold()
                Picker("", selection: $selectedService) {
                    Text("BasicBath").tag(1)
                    Text("SpaBath").tag(2)
                    Text("FullGrooming").tag(3)
                    
                }
                .padding()
                .pickerStyle(.segmented)
                
                Text("Add on Service")
                    .bold()
                Picker("", selection: $selectedAddOnService) {
                    Text("Teeth Brush").tag(1)
                    Text("Blueberry Facial").tag(2)
                    Text("Detangle").tag(3)
                    
                }
                .padding()
                .pickerStyle(.segmented)
                //select a specific groomer or any availble groomer
                Text("Select Groomer")
                    .font(.title2)
                    .bold()
                Picker("", selection: $selectedGroomer) {
                    Text("Lisa").tag(1)
                    Text("Jenny").tag(2)
                    Text("Rose").tag(3)
                    Text("Jisoo").tag(4)
                    Text("Any Avialable").tag(5)
                    
                }
                .padding()
                .pickerStyle(.wheel)
                
                Spacer()
                NavigationLink(destination: {
                    SelectDateView()
                }, label: {
                    ButtonView(title: "Next")
                })
                
                
            }
        }
    }
}
struct CreateApptView_Previews: PreviewProvider {
    static var previews: some View {
        CreateApptView()
    }
}
