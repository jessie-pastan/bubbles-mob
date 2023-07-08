//
//  BusinessDetailView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreDetailView: View {
    let store: Store
    @State var createApptShowed = false
    
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
                    
                    VStack{
                        Text("Service & Prices")
                            .font(.title2)
                            .bold()
                        
                        ForEach(store.groomingService) { item in
                            Text(item.item) + 
                            Text("   $\(item.price)")
                        }.padding(0.1)
                    }
                    //create booking
                    Button {
                        createApptShowed.toggle()
                    } label: {
                        Text("Book an Appointment")
                            .frame(width: 200, height: 39)
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $createApptShowed) {
                        CreateApptView()
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
