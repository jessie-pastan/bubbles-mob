//
//  ManageScheduleView.swift
//  Bubbles
//
//  Created by Jessie P on 7/28/23.
//

import SwiftUI

struct SearchPetView: View {
    @ObservedObject var viewModel = GroomerBookingViewModel()
    var body: some View {
        VStack{
         
        Text("Search pet info")
            
        }
    }
}

struct ManageScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPetView()
    }
}
