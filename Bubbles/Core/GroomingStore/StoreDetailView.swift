//
//  BusinessDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct StoreDetailView: View {
    
    @StateObject var viewModel = StoreManager()
    
    var store: Store
   
    @FirestoreQuery var services: [GroomingService]
    init(store: Store) {
        self.store = store
        self._services = FirestoreQuery(collectionPath: "stores/\(store.id)/groomingServices")
    }
    
    var body: some View {
        VStack{
            Text("Service of  \(store.name) ")
            List( services ){ service in
                NavigationLink(value: service){
                    Text("\(service.item)") +
                    Text("  $ \(service.price)")
                    }
                }
            
            
                Text("Our Groomers")
                List(viewModel.groomers) { groomer in
                    NavigationLink(value: groomer) {
                        Text(groomer.userName)
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
        .navigationDestination(for: User.self) { groomer in
            GroomersView(groomer: groomer, store: store)
        }
        .onAppear {
            Task{
                try await viewModel.queryGroomers(storeId: store.id)
            }
        }
    }
        
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(store: Store.MOCK_STORES[0])
            
    }
}
