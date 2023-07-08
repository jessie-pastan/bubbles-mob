//
//  GroomerRegisterViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/7/23.
//

import Foundation
class GroomerRegisterViewModel: ObservableObject {
    
    @Published var userName = ""
    @Published var password = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var isGroomer = true
    @Published var groomingStore = ""
    
    func registerUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, userName: userName, phoneNumber: phoneNumber, isGroomer: isGroomer, groomingStore: groomingStore)
    }
    
}
