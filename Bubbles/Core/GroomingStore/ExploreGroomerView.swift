//
//  ExploreGroomerView.swift
//  Bubbles
//
//  Created by Jessie P on 7/8/23.
//

import SwiftUI

struct ExploreGroomerView: View {
    var store: Store
    var body: some View {
        
        VStack{
            Text("\(store.name) Groomers")
                .font(.title2)
                .bold()
            VStack{
                GroomerViewRow(imageUrl: "shop4", groomerName: "Lisa", bio: "With 15 years of grooming experinece, Your furbabie will be in a good hand!")
                GroomerViewRow(imageUrl: "shop3", groomerName: "Jenny", bio: "'I Love grooming as puppy love their toys!'")
            }
            VStack{
                GroomerViewRow(imageUrl: "shop12", groomerName: "Rose", bio: "Rose has special grooming technique with her soft and gentle hands for your furbabies.")
                GroomerViewRow(imageUrl: "groomer1", groomerName: "Jisoo", bio: "Graduated from grooming school in Korea , Your furbabie will look great with jisoo's magic!")
            }
        }
        .padding()
    }
}

struct ExploreGroomerView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreGroomerView(store: Store.MOCK_STORES[0])
    }
}
