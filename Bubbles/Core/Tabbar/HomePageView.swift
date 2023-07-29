//
//  HomePageView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct HomePageView: View {
    
    var user: User
   
    var body: some View {
        
            
            TabView {
                StoreListView()
                    .tabItem {
                        VStack{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
              
              if  user.isGroomer {
                GroomerBookingView()
                        .tabItem {
                            VStack{
                                Image(systemName: "calendar")
                                Text("Booking")
                            }
                        }
                  
                  ManageScheduleView()
                      .tabItem {
                          VStack{
                              Image(systemName: "calendar.badge.plus")
                              Text("Manage Schedule")
                          }
                      }
              }else{
                  
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
                  
              }
                
                
                UserProfileView(user: user)
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
