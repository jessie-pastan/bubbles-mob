//
//  BusinessListView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreListView: View {
    @State private var text = ""
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach(0..<6) { store in
                        NavigationLink("this is grooming store") {
                            StoreDetailView(store: Store.MOCK_STORES[0])
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
        StoreListView()
    }
}
