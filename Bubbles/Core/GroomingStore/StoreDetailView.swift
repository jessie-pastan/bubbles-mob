//
//  BusinessDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreDetailView: View {
    var store: Store
    @State var createApptShowed = false
    @State var exploreGroomer = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text(store.name)
                        .font(.largeTitle)
                    Text("'\(store.about)'")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Image(store.storeImageUrl ?? "")
                        .resizable()
                        .frame(width: 350, height: 250)
                        .cornerRadius(15)
                    
                    VStack{
                        Text("Service & Prices")
                            .font(.title2)
                            .bold()
                        
                        ForEach(store.groomingService) { item in
                            Text(item.item) + 
                            Text("   $\(item.price)")
                        }.padding(0.1)
                    }
                    
                    Button {
                        exploreGroomer.toggle()
                    } label: {
                        Text("Explore Groomers")
                            .frame(width: 200, height: 39)
                            .background(Color(.systemMint))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(5)
                    }
                    .sheet(isPresented: $exploreGroomer) {
                        ExploreGroomerView(store: store)
                    }

                    
                    
                    //create booking
                    NavigationLink {
                        CreateApptView(store: store)
                    } label: {
                        Text("Book an Appointment")
                            .frame(width: 200, height: 39)
                            .background(Color(.systemCyan))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding(5)
                    }
                    
                    
                    Text("Open: \(store.businessHour)")
                    Text("Location: \(store.address)")
                    Text("Contact: \(store.phoneNumber)")
                    
                }
            }
        }
    }
}

struct BusinessDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoreDetailView(store: Store.MOCK_STORES[0])
    }
}
