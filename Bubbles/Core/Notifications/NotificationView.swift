//
//  NotificationView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI

struct NotificationView: View {
    
    @StateObject var viewModel = NotificationViewModel()
    
    var body: some View {
    ScrollView{
            VStack{
                ForEach(viewModel.notifications) { noti in
                
                NotificationsRowView(noti: noti)
                
                }
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
