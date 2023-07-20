//
//  AuthService.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift// this library to encode 

@MainActor
class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthService()
    
    init(){
        Task{
            try await fetchCurrentUser()
        }
    }
    
    
    //find current user from uid -> pass uid to api fetchUser func -> assign return to self.currentUser -> and assign curentuser to self.userSession
    func fetchCurrentUser() async throws {
        self.userSession = Auth.auth().currentUser
        guard let uid = self.userSession?.uid else { return }
        self.currentUser =  try await UserService.fetchUserData(uid: uid)
        
    }
    
    func LoginUser(email: String, passord: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: passord)
            self.userSession = result.user
            // After Log In need to Fetch User every time 
            try await fetchCurrentUser()
            
            print("DEBUG: Logged In")
            
        }catch{
            print("DEBUG: failed to log user in with error \(error.localizedDescription)")
        }
    }
    
    
    
    func createUser(email: String, password: String, userName: String, phoneNumber: String, isGroomer: Bool, groomingStoreId: String) async throws {
        do {
            //crate user in Auth
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: Did create user")
            self.userSession = result.user
            // upload user in firestore
            await uploadUserData(uid: result.user.uid, email: email, userName: userName, phoneNumber: phoneNumber, isGroomer: isGroomer, groomingStoreId: groomingStoreId )
            print("DEBUG: Did upload user data")
        }catch{
            print("DEBUG: Failed to register user with error \(error.localizedDescription)")
        }
    }
    
    
     func uploadUserData(uid: String, email: String, userName: String, phoneNumber: String, isGroomer: Bool, groomingStoreId: String) async {
        let user = User(id: uid, email: email, userName: userName, phoneNumber: phoneNumber, groomingStoreId: groomingStoreId, isGroomer: isGroomer )
       self.currentUser = user
       //encode swift object to json
       guard let encodeUser = try? Firestore.Encoder().encode(user) else { return }
       //insert in firestore
       try? await Firestore.firestore().collection("users").document(uid).setData(encodeUser)
       
    }

    
    func logOut() async throws {
        do {
            try  Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("DEBUG: Logged Out")
        } catch {
            print("DEBUG: Failed to Log Out  with \(error.localizedDescription).")
        }
        
    }
    
    
    
}
