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
        VStack(alignment: .leading){
            //MARK: Services
            VStack(alignment: .leading) {
               
                Text("\(store.name) Services").bold().font(.title2).padding(.leading, 20).padding(.bottom, -40).padding(.top,-10)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack( spacing: 10){
                        
                        ForEach(services) { service in
                            NavigationLink(value: service) {
                                ServiceRowView(service: service)
                            }
                            .accentColor(.black)
                        }.padding(.vertical)
                    }
                    .padding(.horizontal)
                }
            }
                
            //MARK: Groomers
            VStack(alignment: .leading){
                Text("Our Groomers").bold().font(.title2).padding(.top,-10).padding(.bottom, -25).padding(.leading, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack( spacing: 10){
                        ForEach(viewModel.groomers) { groomer in
                            NavigationLink(value: groomer) {
                                GroomerRowView(groomer: groomer)
                                
                            }
                            .accentColor(.black)
                        }.padding(.vertical)
                    }
                    .padding(.horizontal)
                }
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
            
        
        //MARK: Create booking Button
        VStack(alignment: .center) {
            NavigationLink {
                CreateBookingView(store: store)
            } label: {
                Text("Book an appointment")
                    .bold()
                    .frame(width: 350, height: 39)
                    .background(Color(.systemCyan))
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(5)
            }
        }
    }
}
struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(store: Store.MOCK_STORES[0])
    }
}
