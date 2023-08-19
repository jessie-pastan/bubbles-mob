//
//  BusinessListView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct StoreListView: View {
    
    @StateObject var viewModel = StoreManager()
    @EnvironmentObject var root : Router
    @State private var text = ""
    
    var filteredStores : [Store] {
        guard  !text.isEmpty else {return viewModel.stores}
        return viewModel.stores.filter {$0.name.localizedCaseInsensitiveContains(text)}
    }
    
    
    
    var body: some View {
        NavigationStack(path: $root.path ){
          
            ScrollView{
                LazyVStack{
                    ForEach(filteredStores) { store in
                        NavigationLink(value: store) {
                            ZStack{
                                
                                StoreRowView(store: store)
                                
                                NavigationLink(value: store) {
                                    Text("Book an appointment")
                                        .frame(width: 200, height: 39)
                                        .background(Color(.systemCyan))
                                        .foregroundColor(.white)
                                        .cornerRadius(15)
                                        .padding(5)
                                }
                               
                            }
                        }
                        .accentColor(.black)
                    }
                }
            }
            .navigationDestination(for: Store.self) { store in
                StoreDetailView(store: store)
                
            }
        }
        .searchable(text: $text, prompt: "Search store")
    }
}

struct BusinessListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
            .environmentObject(Router())
            
    }
}
