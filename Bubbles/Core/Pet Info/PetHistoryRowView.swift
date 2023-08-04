//
//  PetHistoryRowView.swift
//  Bubbles
//
//  Created by Jessie P on 8/4/23.
//

import SwiftUI

struct PetHistoryRowView: View {
    
    var petHistory: GroomingHistory
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(petHistory.date.formatted(date: .abbreviated, time: .omitted))")
            HStack{
                Text("\(petHistory.service) ")
                Text("$\(petHistory.servicePrice)")
                
            }
            HStack{
                Text("\(petHistory.addOn) ")
                Text("$\(petHistory.addOnPrice)")
            }
            
            Text("Detail: \(petHistory.detail)")
            Text("Groom by: \(petHistory.groomBy)")
        Divider()
        }
        .font(.subheadline)
        .padding(.horizontal)
    }
}

struct PetHistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        PetHistoryRowView(petHistory:  GroomingHistory.MOCK_HISTORIES[0])
    }
}
