//
//  Banner.swift
//  Bubbles
//
//  Created by Jessie P on 8/19/23.
//

import SwiftUI

struct Banner: View {
    var body: some View {
        HStack{
            VStack{
                Text("Bubbles")
                    .bold()
                    .font(.title2)
                
                Text("'Find the grooming professtional in your area'")
                    .multilineTextAlignment(.center)
                Button {
                    //explore
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 100, height: 39)
                            .background(Color(.systemCyan))
                            .opacity(0.1)
                            .cornerRadius(15)
                        
                        Text("Explore")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
            }
            Image("bubbles banner")
                .resizable()
                .scaledToFit()
                //.frame(width: 250, height: 250)
            
        }
        
        .frame(maxWidth: .infinity)
        .background(Color(.systemCyan).opacity(0.3))
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner()
    }
}
