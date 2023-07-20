//
//  StoreManager.swift
//  Bubbles
//
//  Created by Jessie P on 7/19/23.
//

import Foundation
import Firebase

@MainActor
class StoreManager: ObservableObject {
    
    @Published var stores = [Store]()
    @Published var groomers = [User]()
    
    init() {
        Task{
            self.stores =  try await UserService.fetchAllStores()
        }
    }
    
    func queryGroomers(storeId : String) async throws  {
        
        let snapshot = try await Firestore.firestore().collection("users").whereField("groomingStoreId", isEqualTo: storeId).getDocuments()
        self.groomers = snapshot.documents.compactMap({try? $0.data (as : User.self )})
       
    }
    
    
    
    
    
    
    
}
