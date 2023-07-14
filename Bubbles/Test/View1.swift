//
//  View1.swift
//  Bubbles
//
//  Created by Jessie P on 7/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct View1: View {
    @EnvironmentObject var router : Router
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            VStack{
                ForEach(Store.MOCK_STORES) { store  in
                    NavigationLink(value: store) {
                        Text(store.name)
                    }
                }
            }
            .navigationDestination(for: Store.self) { store in
                View2(store: store)
            }
        }
    }
}

struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
            .environmentObject(Router())
        
    }
}
