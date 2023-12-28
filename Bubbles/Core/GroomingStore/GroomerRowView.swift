//
//  GroomerRowView.swift
//  Bubbles
//
//  Created by Jessie P on 8/22/23.
//

import SwiftUI

struct GroomerRowView: View {
    var groomer: User
   
    var body: some View {
        HStack{
            Image(groomer.profileUrl ?? "shop2")
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 4.5)
                .cornerRadius(15)
            Text(groomer.userName)
               
        }
                .padding(.horizontal,30)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(25)
                // shadows..
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
    }
}

struct GroomerRowView_Previews: PreviewProvider {
    static var previews: some View {
        GroomerRowView(groomer: User.MOCK_USERS[0])
    }
}
