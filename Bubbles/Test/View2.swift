//
//  View2.swift
//  Bubbles
//
//  Created by Jessie P on 7/11/23.
//

import SwiftUI

struct View2: View {
   
    var store : Store
 
    var body: some View {
        
            VStack{
                Text("View2")
                Text("Service of  \(store.name) ")
                List(store.groomingService){ service in
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
                    BookingView2()
                } label: {
                    Text("Create an appointment")
                }

            }
            .navigationDestination(for: GroomingService.self) { service in
               View3(service: service)
            }
            .navigationDestination(for: Groomer.self) { groomer in
                View4(groomer: groomer)
            }
        }
}

struct View2_Previews: PreviewProvider {
    static var previews: some View {
        View2(store: Store.MOCK_STORES[0])
           
    }
}
