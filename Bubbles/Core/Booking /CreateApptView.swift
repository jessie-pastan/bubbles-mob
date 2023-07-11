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
    
    @EnvironmentObject var viewModel : BookingViewModel
    
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
                HStack{
                    Picker("", selection: $viewModel.petName) {
                        ForEach(pets) { pet in
                            Text("\(pet.name)").tag("\(pet.name)")
                        }
                    }
                    .padding()
                    .pickerStyle(.menu)
                    
                    Button {
                        // update petId
                        viewModel.store = store.name
                        
                        print(viewModel.store)
                       
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 100, height: 39)
                                .foregroundColor(Color(.systemMint))
                            Text("Confirm Pet")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
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
            .environmentObject(BookingViewModel())
            
    }
}
