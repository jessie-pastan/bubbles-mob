//
//  NotificationsRowView.swift
//  Bubbles
//
//  Created by Jessie P on 7/29/23.
//

import SwiftUI

struct NotificationsRowView: View {
    var noti : Notification
    var body: some View {
        VStack(alignment: .trailing){
            //time stamp
            HStack{
                Text(noti.timeStamp.formatted(date: .abbreviated, time: .omitted))
                Text("")
                Text(noti.timeStamp.formatted(date: .omitted, time: .shortened))
            }
            .padding(.horizontal)
            .font(.callout)
            .opacity(0.3)
            .foregroundColor(.gray)
            
           
            if noti.type == .reminder {
                VStack(alignment: .trailing,spacing: 10){
                    Text("\(noti.type.notificationMessage) for \(noti.petName) at \(noti.time), \(noti.date.formatted(date: .abbreviated, time: .omitted)) with \(noti.userName) at \(noti.store). ")
                        .font(.callout)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    
                }
                .frame(width: 280, height: 100)
                .background(Color(.systemCyan).opacity(0.3).cornerRadius(15))
                
            }else{
                VStack{
                    Text("\(noti.petName) \(noti.type.notificationMessage). See you soon!")
                        .font(.callout)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: 250, height: 70)
                .background(Color(.systemMint).opacity(0.3).cornerRadius(15))
                
            }
             
             
            Divider()
            
        }.padding(.horizontal)
    }
            
}


