//
//  ApptView.swift
//  Bubbles
//
//  Created by Jessie P on 7/5/23.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAuth

struct ApptView: View {
    var user : User
    @StateObject var viewModel = ApptViewModel()
    
    var body: some View {
        
        VStack{
            if let appts = viewModel.sortedAppts.filter({ $0.isDone == false}) {
                ScrollView {
                    Text("Upcoming Appiontments")
                        .font(.title)
                        .bold()
                    ForEach(appts) { appt in
                        AppointmentViewRow(appt: appt)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task{
                try await viewModel.fetchAppt()
            }
        }
    }
}

struct ApptView_Previews: PreviewProvider {
    static var previews: some View {
        ApptView(user: User.MOCK_USERS[0])
    }
}
