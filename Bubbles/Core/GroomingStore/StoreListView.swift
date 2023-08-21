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
            ScrollView{
                Spacer()
                VStack(alignment: .leading){
                    Text("Categories").bold().font(.title2).padding(.top,-20)
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
