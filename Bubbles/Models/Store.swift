//
//  Business.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import Foundation
struct Store: Codable, Identifiable {
    
    let id: String
    var name: String
    var storeImageUrl: String?
    var address: String
    var phoneNumber: String
    var businessHour: String
    var about: String
    var rating: Double
    var liked: Bool
    var groomingService: [GroomingService]
}
//create Mock stores
extension Store {
    static var MOCK_STORES: [Store] = [
        
        .init(id: "123", name: "PuppyPaws", storeImageUrl: "shop1", address: "1122 73th St. Manhattan,NY", phoneNumber: "212.235.2222", businessHour: "09am-08pm daily", about: "We are the best pet grooming Store in your area", rating: 4.7, liked: false, groomingService: GroomingService.MOCK_GROOMIMGSERVICE),
        
            .init(id: NSUUID().uuidString, name: "Silver Sissor Grooming", storeImageUrl: "shop2", address: "Midtown Manhattan,NY", phoneNumber: "212.232.2343", businessHour: "09am-08pm daily", about: "Professional groomers with high experience", rating: 4.9,liked: false, groomingService: GroomingService.MOCK_GROOMIMGSERVICE),
        
            .init(id: NSUUID().uuidString, name: "Poochy Blossum",storeImageUrl: "shop3", address: "Downtown Manhattan,NY", phoneNumber: "213.359.0023", businessHour: "09am-08pm daily", about: "Take the best care to your little furbaby", rating: 4.0, liked: false, groomingService: GroomingService.MOCK_GROOMIMGSERVICE)
        ]
    /*
        .init(id: NSUUID().uuidString, name: "Smiley Pups",storeImageUrl: "shop4", address: "Soho, Manhattan,NY", phoneNumber: "542.222.2532", businessHour: "09am-08pm daily", about: "We are the best pet grooming Store in your area", rating: 4.9, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Meow Meow Love",storeImageUrl: "shop5", address: "Financial district, Manhattan,NY", phoneNumber: "254.225.2892", businessHour: "09am-08pm daily", about: "Purr... kitty cat temper available now!", rating: 5, liked: false),
        
        .init(id: NSUUID().uuidString, name: "BubblyBath & Scissor",storeImageUrl: "shop6", address: "South Street Seaport,Manhattan,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.3, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Little Princess Grooming",storeImageUrl: "shop7", address: "Koreatown, Manhattan,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "Leave your princess with us.. we will take the rest! ", rating: 4.2, liked: false ),
        
        .init(id: NSUUID().uuidString, name: "Daddy Mommy Fur",storeImageUrl: "shop8", address: "Brookyln,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 3.9, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Best Pet Grooming",storeImageUrl: "shop9", address: "Brooklyn,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.5, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Bathtub and Brush",storeImageUrl: "shop10", address: "Brooklyn,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.2, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Huggy Doggy",storeImageUrl: "shop11", address: "Woodside,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.8, liked: false),
        
        .init(id: NSUUID().uuidString, name: "Hong! meow.. Spa",storeImageUrl: "shop12", address: "Woodside,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 5, liked: false),
        
        .init(id: NSUUID().uuidString, name: "With Love Grooming",storeImageUrl: "shop13", address: "Flushing,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.8, liked: false),
        
        .init(id: NSUUID().uuidString, name: "K-nine Style",storeImageUrl: "shop14", address: "Flushing,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.7,liked: false),
        
        .init(id: NSUUID().uuidString, name: "PuppyClub",storeImageUrl: "shop15", address: "Flushing,NY", phoneNumber: "212.222.2222", businessHour: "09am-08pm daily", about: "We are best pet grooming Store in your area", rating: 4.6,liked: false)
      */
        
    
}
