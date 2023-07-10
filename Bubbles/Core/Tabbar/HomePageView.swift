//
//  HomePageView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct HomePageView: View {
    
    var user: User
    @State var selectedIndex = 0
    var body: some View {
        
            
            TabView(selection: $selectedIndex) {
                StoreListView(stores: Store.MOCK_STORES)
                    .onAppear(perform: {
                        selectedIndex = 0
                    })
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }.tag(0)
                    
              ApptView()
                    
                    .tabItem {
                        VStack{
                            Image(systemName: "calendar")
                            Text("Appointment")
                        }
                    }
              NotificationView()
                    .tabItem {
                        VStack{
                            Image(systemName: "bubble.right")
                            Text("Notifications")
                        }
                    }
            GroomingHistoryView()
                    .tabItem {
                        VStack{
                            Image(systemName: "bathtub")
                            Text("History")
                        }
                    }
                UserProfileView(user: user, selectedIndex: $selectedIndex)
                    .tabItem {
                        VStack{
                            Image(systemName: "person")
                            Text("Profile")
                        }
                    }
            }
            
        }
    }


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(user: User.MOCK_USERS[0])
    }
}
