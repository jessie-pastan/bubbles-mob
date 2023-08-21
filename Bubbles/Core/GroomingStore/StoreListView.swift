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
    @State var selectedCatagory: StoreCategory = StoreCategory.categories.first!
    
    var filteredStores : [Store] {
        guard  !text.isEmpty else {return viewModel.stores}
        return viewModel.stores.filter {$0.name.localizedCaseInsensitiveContains(text)}
    }
    
    
    var body: some View {
        NavigationStack(path: $root.path ){
           Banner()
            ScrollView {
                
                VStack(alignment: .leading){
                    Text("Categories").bold().font(.title2).padding(.top,-10).padding(.bottom, -5)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 15){
                            ForEach(StoreCategory.categories) { category in
                                HStack(spacing: 10){
                                    Image(category.icon)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                    Text(category.title)
                                        .bold()
                                    
                                }
                                .foregroundColor( selectedCatagory.id == category.id ? .white : .black)
                                .padding(.vertical, 9)
                                .padding(.horizontal)
                                .background(selectedCatagory.id == category.id ? Color(.systemCyan).opacity(0.3) : Color(.systemGray).opacity(0.08))
                                .clipShape(Capsule())
                                //shadows
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y:5 )
                                //button dynamic when tap
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedCatagory = category
                                    }
                                }
                                
                            }.padding(.leading, 1)
                        }
                    }
                    
                    
                    
                }.padding()
                
                
                VStack(alignment: .leading) {
                    Text("Stores").bold().font(.title2).padding(.leading, 20).padding(.bottom, -20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack( spacing: 10){
                            
                            ForEach(filteredStores) { store in
                                NavigationLink(value: store) {
                                    StoreRowView(store: store)
                                    
                                }
                                .accentColor(.black)
                            }.padding(.vertical)
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationDestination(for: Store.self) { store in
                    StoreDetailView(store: store)
                    
                }
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
