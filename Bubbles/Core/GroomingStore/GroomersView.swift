//
//  GroomersView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import SwiftUI

struct GroomersView: View {
    
    var groomer: Groomer
    var store: Store
    
    
    var body: some View {
        
        VStack{
            Spacer()
            GroomerViewRow(imageUrl: groomer.imageUrl ?? "", groomerName: groomer.name, bio: groomer.bio)
            Spacer()
            NavigationLink {
                //booking
                BookingWithGroomerView(store: store, groomer: groomer)
        
            } label: {
                ButtonView(title: "Book \(groomer.name)")
            }
            .padding()
            
        }
        
    }
}

struct GroomersView_Previews: PreviewProvider {
    static var previews: some View {
        GroomersView(groomer: Groomer.groomers[0], store: Store.MOCK_STORES[0])
    }
}
