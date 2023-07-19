//
//  User.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
struct User: Codable, Identifiable {
    
    let id: String
    let email: String
    var userName: String
    var phoneNumber: String
    var profileUrl: String?
    var bio: String?
    
    //client
    var pet: [Pet]?
    var Appiontments: [Appointment]?
    var groomingReferenceUrl: String?
    var vaccineUrl: String?
    
    
    //groomer
    var groomingStore: String?
    var groomingStoreId: String?
    var groomerNote: [GroomerNote]?
    
    //verify if this account is client or groomer
    var isGroomer: Bool
    
    
    
}


extension User  {
    
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, email: "test@gmail.com", userName: "testUser", phoneNumber: "927.333.3333", pet: [Pet.MOCK_PETS[0]], isGroomer: false)
        
        
    ]}
