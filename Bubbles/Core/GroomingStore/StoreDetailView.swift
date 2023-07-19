//
//  BusinessDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreDetailView: View {
    
   
    var store: Store
   
    @State var exploreGroomer = false
    
    var body: some View {
        VStack{
            Text("Service of  \(store.name) ")
            List(store.groomingService ?? GroomingService.MOCK_GROOMIMGSERVICE){ service in
                NavigationLink(value: service){
                    Text("\(service.item)") +
                    Text("  $ \(service.price)")
                    }
                }
            
            if let groomers = store.groomer {
                    Text("Our Groomers")
                
                List(groomers) { groomer in
                    NavigationLink(value: groomer) {
                        Text(groomer.name)
                    }
                }
            }
            
            
            NavigationLink {
                CreateBookingView(store: store)
            } label: {
                Text("Book an appointment")
                    .frame(width: 200, height: 39)
                    .background(Color(.systemCyan))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(5)
                
            }

        }
        .navigationDestination(for: GroomingService.self) { service in
           GroomingServiceDetailView(service: service)
        }
        .navigationDestination(for: Groomer.self) { groomer in
            GroomersView(groomer: groomer, store: store)
        }
       
        
        
    }
        
        
        


    
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(store: Store.MOCK_STORES[0])
            
    }
}
