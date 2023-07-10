//
//  GroomerViewRow.swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct GroomerViewRow: View {
    var imageUrl = ""
    var groomerName = ""
    var bio = ""
    
    var body: some View {
        
        VStack {
            Image(imageUrl)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            Text(groomerName)
                .font(.footnote)
                .fontWeight(.semibold)
            VStack(alignment: .leading){
                Text(bio)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                
            }
            
        }
    }
}

struct GroomerViewRow_Previews: PreviewProvider {
    static var previews: some View {
        GroomerViewRow(imageUrl: "shop4", groomerName: "Lisa", bio: "With 15 years of grooming experinece, Your furbabie will be in a good hand!")
    }
}
