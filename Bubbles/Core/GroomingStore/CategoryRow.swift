//
//  CatagoryRow.swift
//  Bubbles
//
//  Created by Jessie P on 8/18/23.
//

import SwiftUI

struct CategoryRow: View {
    
    var title: String
    var icon: String
    var tag: Int
    @State var tappedButton : Int? = nil
    var body: some View {
        
        HStack{
            Button  {
                tappedButton = tag
            } label: {
                Capsule()
                    .stroke(lineWidth: 1)
                    .frame(width: 150, height: 39)
                    .overlay(
                        HStack(spacing: 10) {
                            Image(icon)
                                .resizable()
                                .frame(width: 30, height: 30)
                                
                            Text(title).font(.callout)
                                
                        })
            }
            .tag(tag)

                
            
        }.accentColor(tappedButton == tag ? Color(.systemMint) : .black)
        
        }
        
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(title: "Dog grooming", icon: "dog", tag: 1,tappedButton: 1)
    }
}
