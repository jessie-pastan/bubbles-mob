//
//  TestTabView.swift
//  Bubbles
//
//  Created by Jessie P on 7/11/23.
//

import SwiftUI

struct TestTabView: View {
    

    var body: some View {
        
        TabView {
            View1()
                .tabItem {
                    Text("View1")
                        .font(.title)
                }
            
            Profile()
                .tabItem {
                    Text("Profile")
                        .font(.title)
                }
        }
    }
}

struct TestTabView_Previews: PreviewProvider {
    static var previews: some View {
        TestTabView()
            .environmentObject(Router())
    }
}
