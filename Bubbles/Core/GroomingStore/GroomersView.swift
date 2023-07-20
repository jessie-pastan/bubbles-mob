//
//  GroomersView.swift
//  Bubbles
//
//  Created by Jessie P on 7/12/23.
//

import SwiftUI

struct GroomersView: View {
    
    var groomer: User
    var store: Store
    
    
    var body: some View {
        
        VStack{
            Spacer()
            GroomerViewRow(imageUrl: groomer.profileUrl ?? "shope4", groomerName: groomer.userName, bio: groomer.bio ?? "\(groomer.userName) has exellent grooming techniques. Your furbabies will be in good hands!")
            Spacer()
            NavigationLink {
                //booking
                BookingWithGroomerView(store: store, groomer: groomer)
        
            } label: {
                ButtonView(title: "Book \(groomer.userName)")
            }
            .padding()
            
        }
        
    }
}

struct GroomersView_Previews: PreviewProvider {
    static var previews: some View {
        GroomersView(groomer: User.MOCK_USERS[0], store: Store.MOCK_STORES[0])
    }
}
