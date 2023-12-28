//
//  Review.swift
//  Bubbles
//
//  Created by Jessie P on 8/21/23.
//

import Foundation
struct Review: Identifiable, Codable, Hashable {
    let id: String
    var creatorId: String
    var imageURL: String?
    var text: String
    var storeLink: String
    var imageString: String?
}

extension Review {
    static let MOCK_Reviews : [Review] = [
        .init(id: "1", creatorId: "1", text: "Cooper got groom at puppy paws 2 weeks ago. He turned out to be a little cute teddy bear! we loved how Jenny gave him speacial care with his sensitive skin. l give this place a 10! The store is clean, beautiful and well organized. ", storeLink: "Puppy paws", imageString: "user5"),
        .init(id: "2", creatorId: "2", text: "We've been finding groomer who fit our tuff Tiny, Chihuahua, 8. who can be so difficult when it comes to grooming time, then we found Danny at Silver scissor grooming. Danny's so kind and professional. Tiny got back after groom with happiness and fresh", storeLink: "Silver scissor grooming", imageString: "shop1"),
        .init(id: "3", creatorId: "3", text: "They did a very good job. I brought my toy Papillon in for the first time. Did exactly what I asked for- short for winter and fluffy face. However very pricey; for a dog that weighs 5 pounds it cost 200 bucks. Front desk was friendly.They cut nails well but forgot to cut the fifth one on the side of the foot that I have trouble cutting. I will let them know next time not to forget about that one! Anyways overall happy customer. I dropped her off at 10:45am and she was done and ready for pick up by 2pm.", storeLink: "D for Doggy ", imageString: "user2"),
        .init(id: "4", creatorId: "4", text: "They do a super job grooming Nobu - Giving him a neat and stylish haircut which makes it easier to brush his fur at home and helps reducing his shedding. The groomer, Hailey, is very kind, friendly and sweet. She does a perfect job and always gets Nobu to relax by petting him, giving him chicken treats and concludes his grooming with a gift of a stylish accessory such as a colorful bandana or a St. Patrick's Day necktie. ", storeLink: "Meow Meow Love", imageString: "user3"),
        
    ]
}
