//
//  CreateBookingView2.swift
//  Bubbles
//
//  Created by Jessie P on 7/20/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth


struct CreateBookingView2: View {
    @EnvironmentObject var viewModel : BookingViewModel

    var store : Store
   
    var body : some  View {
        VStack{
            Text(store.name )
            
            ForEach(viewModel.pets) { pet in
                Text(pet.name)
            }
        
            
            NavigationLink {
                CreateBookingView(store: store)
            } label: {
                Text("press")
            }
        }
    }
}


struct CreateBookingView2_Previews: PreviewProvider {
    static var previews: some View {
        CreateBookingView2(store: Store.MOCK_STORES[0])
            .environmentObject(BookingViewModel())
    }
}
