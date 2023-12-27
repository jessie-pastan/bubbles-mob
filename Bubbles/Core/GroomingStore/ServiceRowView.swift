//
//  ServiceRowView.swift
//  Bubbles
//
//  Created by Jessie P on 8/22/23.
//

import SwiftUI

struct ServiceRowView: View {
    var service: GroomingService
    var body: some View {
        
        VStack{
            Image("bathtub")
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 5 )
                .cornerRadius(15)
            Text(service.item)
                .bold()
            Text("$") +
            Text(String(service.price))
                .font(.footnote)
        }
        .padding(.horizontal,30)
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(25)
        // shadows..
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
    }
}


struct ServiceRowView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceRowView(service: GroomingService.MOCK_GROOMIMGSERVICE[0])
    }
}
