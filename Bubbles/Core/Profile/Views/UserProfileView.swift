//
//  UserProfileView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct UserProfileView: View {
    
    var user: User
    
    @FirestoreQuery var pets: [Pet]
    
    init(user: User) {
        self.user = user
        self._pets = FirestoreQuery(collectionPath: "users/\(user.id)/pets")
    }
    
    var body: some View {
        NavigationStack{
            
            List {
                Section{
                    HStack{
                        Image("groomer1")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(100)
                        VStack(alignment: .leading){
                            Text(user.userName)
                            Text(user.email)
                        }
                    }
                }
                
               
                
                
                    Section("Pet") {
                        NavigationLink{
                            // Add pet profileView
                            PetInfoView()
                            
                        } label: {
                            VStack{
                                Text("Add pet")
                            }
                            .font(.title3)
                            .accentColor(.black)
                        }
                        
                        ForEach(pets){ pet in
                            NavigationLink {
                                // Pet profile page
                                PetProfileView(pet: pet)
                            } label: {
                                VStack(alignment: .leading){
                                    Text(pet.name)
                                }
                                .font(.title3)
                            }
                        }
                }
                
               
                Section("Setting") {
                    NavigationLink {
                        // edit profile page
                       
                    } label: {
                        VStack{
                            Text("Edit Profile")
                        }
                        .font(.title3)
                    }
                }
            }
                Button {
                    Task{
                        //need .shared so contentViewModel will know what is going on
                        try await AuthService.shared.logOut()
                    }
                } label: {
                    Text("Log Out")
                        .bold()
                        .frame(width: 350, height: 39)
                        .background(Color(.systemRed))
                        .cornerRadius(15)
                        .foregroundColor(.white)
                }
            }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: User.MOCK_USERS[0])
            .environmentObject(AddPetViewModel())
    }
}
