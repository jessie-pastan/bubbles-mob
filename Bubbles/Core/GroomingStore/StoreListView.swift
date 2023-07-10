//
//  BusinessListView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreListView: View {
    var stores: [Store]
    @State private var text = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(0..<stores.count, id: \.self) { index in
                        NavigationLink {
                            StoreDetailView(store: stores[index])
                        } label: {
                            StoreRowView(store: stores[index])
                        }
                    }
                }
            }
        }
        
        .searchable(text: $text, prompt: "Search")
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView(stores: Store.MOCK_STORES)
    }
}
