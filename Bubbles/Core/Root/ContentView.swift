//
//  ContentView.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import SwiftUI
// this first view to verify currentUser and currentSession 
struct ContentView: View {
    @StateObject var viewModel  = ContentViewModel()
    var body: some View {
        Group{
            if viewModel.userSession  == nil {
                
                LoginView()
                    
                
            }else if let currentUser = viewModel.currentUser {
                
                HomePageView(user: currentUser )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
