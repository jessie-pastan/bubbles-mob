//
//  ButtonView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct ButtonView: View {
    
    var title: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 350, height: 39)
                .foregroundColor(Color(.systemCyan))
            Text(title)
                .foregroundColor(.white)
                .bold()
            
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Complete Booking")
    }
}
