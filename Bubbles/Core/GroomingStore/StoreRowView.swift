//
//  StoreRowView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreRowView: View {
    let store: Store
    
    var body: some View {
        
        VStack{
            
            Image(store.storeImageUrl ?? "")
                .resizable()
                .frame(width: 350, height: 250)
            
            VStack(alignment: .leading){
               
                    Text(store.name)
                        .font(.title)
                    Text(store.address)
                        .font(.title2)
                    Text(store.businessHour)
                        .font(.title2)
                    Text(store.phoneNumber)
                        .font(.title2)
                    Text(store.about)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            Divider()
        }
        
    }
}

struct StoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        StoreRowView(store: Store.MOCK_STORES[0])
    }
}
