//
//  ContentViewModel.swift
//  Bubbles
//
//  Created by Jessie P on 7/6/23.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    //instanciate shared object
    private let service = AuthService.shared
    
    // so confused here lol
    private var cancellables = Set<AnyCancellable>()
    // same as AuthService class becoz we will share (log in, log out status with these property
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    //I forgot to init this class. that's why no show Main Page after logged in ....T^T
    init(){
        setupSubscibers()
    }
    
    func setupSubscibers() {
        //.sink is connect to subscriber
        
        service.$userSession.sink {[weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
        
        service.$currentUser.sink {[weak self] currentUser in
            self?.currentUser = currentUser
        }
        .store(in: &cancellables)
    }
}
