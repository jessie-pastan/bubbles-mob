//
//  CreateApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct CreateApptView: View {
    
    @StateObject var viewModel = BookingViewModel()
    
    @FirestoreQuery var pets: [Pet]
    
    var store: Store
    
    init(store: Store){
        self._pets = FirestoreQuery(collectionPath: "users/\(Auth.auth().currentUser?.uid ?? "")/pets")
        self.store = store
    }
    
    var body: some View {
        
        //select service
        NavigationStack{
            Spacer()
            
            VStack( spacing: 60){
                Text("Book Grooming for")
                    .font(.title2)
                    .bold()
                Picker("", selection: $viewModel.petName) {
                    ForEach(pets) { pet in
                        Text("\(pet.name)").tag("\(pet.name)")
                        
                    }
                    
                }
                .padding()
                .pickerStyle(.menu)
                
                Text("Select Service")
                    .font(.title2)
                    .bold()
                Picker("", selection: $viewModel.selectedService) {
                    Text("BasicBath").tag("BasicBath")
                    Text("SpaBath").tag("SpaBath")
                    Text("FullGrooming").tag("FullGrooming")
                    
                }
                .padding()
                .pickerStyle(.segmented)
                
               
                
                NavigationLink(destination: {
                    SelectGroomerView()
                }, label: {
                    ButtonView(title: "Next")
                })
                .padding(.bottom, 80)
                
                
            }
        }
    }
}
struct CreateApptView_Previews: PreviewProvider {
    static var previews: some View {
        CreateApptView(store: Store.MOCK_STORES[0])
            
    }
}
