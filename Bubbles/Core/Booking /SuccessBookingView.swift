//
//  SuccessBookingView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import SwiftUI

struct SuccessBookingView: View {
   
    @EnvironmentObject var root : Router
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack{
            Image(systemName: "pawprint")
                .resizable()
                .frame(width: 40, height: 40)
            Text("Thank you!")
            Text("Your booking has succeed")
            
            
            Button {
                root.backToRoot()
            } label: {
                Text("Back to HomePage")
            }
        }
    }
}

struct SuccessBookingView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessBookingView()
    }
}
