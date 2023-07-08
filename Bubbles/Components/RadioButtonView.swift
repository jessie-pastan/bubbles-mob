//
//  RadioButtonView.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import SwiftUI

struct RadioButtonView: View {
    
    @Binding var isDog: Bool
    
    var body: some View {
        
        
        Text("")
            .frame(width: 8, height: 8)
            .background(isDog ? .black : .white)
            .cornerRadius(100)
            .foregroundColor(.black)
            .padding()
        //stroke modified roundRectangled
            .overlay(RoundedRectangle(cornerRadius: 100)
            .stroke(Color.black, lineWidth: 6)
            .scaleEffect(0.6)
            )
    }
}

struct RadioButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RadioButtonView(isDog: .constant(true))
    }
}
