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
            Button {
                //
            } label: {
                Image(systemName: "heart")
                    .font(.footnote)
                    .foregroundColor(.black)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
            Image(store.storeImageUrl ?? "shop2")
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 2.5 )
                .cornerRadius(15)
            Text(store.name)
                .bold()
            Text(store.phoneNumber)
                .font(.footnote)
            Text(store.businessHour)
                .font(.footnote)
            Text(store.address)
            .font(.footnote)
            
        }
                .padding(.horizontal,30)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(25)
                // shadows..
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
    }
}

struct StoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        StoreRowView(store: Store.MOCK_STORES[0])
    }
}
// Extending View To Get Screen Frame...
extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}
