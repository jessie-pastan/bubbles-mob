//
//  ReviewRowView.swift
//  Bubbles
//
//  Created by Jessie P on 8/22/23.
//

import SwiftUI

struct ReviewRowView: View {
    var review : Review
    var body: some View {
        HStack{
            Image(review.imageString ?? "shop7")
                .resizable()
                .scaledToFit()
                .frame(width: getRect().width / 4.5)
                .cornerRadius(15)
            Text(review.text)
                .font(.callout)
                .multilineTextAlignment(.leading)
                .frame(width: 240, height: 50)
               
        }
                .padding(.horizontal,30)
                .padding(.vertical)
                .background(Color.white)
                .cornerRadius(25)
                // shadows..
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 10, y: 0)
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(review: Review.MOCK_Reviews[0])
    }
}


