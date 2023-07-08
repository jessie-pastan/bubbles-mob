//
//  RegisterViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
class RegisterViewModel: ObservableObject {
    
    @Published var userName = ""
    @Published var password = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var isGroomer = false
    
    
    func registerUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, userName: userName, phoneNumber: phoneNumber, isGroomer: isGroomer, groomingStore: "")
    }
    
    
}
