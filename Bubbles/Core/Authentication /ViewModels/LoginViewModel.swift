//
//  LoginViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func loginUser() async throws {
        try await AuthService.shared.LoginUser(email: email, passord: password)
    }
    
}
